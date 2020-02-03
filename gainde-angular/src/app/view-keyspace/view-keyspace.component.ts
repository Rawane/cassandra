import { Component, OnInit,Inject } from '@angular/core';
import {FormGroup,FormBuilder,Validators} from '@angular/forms'; 
import {Router} from '@angular/router';
import {Subscription} from 'rxjs';
import {NestedTreeControl} from '@angular/cdk/tree';
import {MatTreeNestedDataSource} from '@angular/material/tree';
import {MatTableDataSource} from '@angular/material/table';
import {MatDialog, MatDialogRef,MAT_DIALOG_DATA} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import {GaindeService} from '../services/gainde.service';
import {ConnectionDTO} from '../model/connection-dto';
import {KeyspaceDTO} from '../model/keyspace-dto';
import{DialogData} from '../view-connections/view-connections.component'
interface Meta {
  name:string; 
  metas:Meta[];
}
@Component({
  selector: 'app-view-keyspace',
  templateUrl: './view-keyspace.component.html',
  styleUrls: ['./view-keyspace.component.scss']
})
export class ViewKeyspaceComponent implements OnInit {
  treeControl = new NestedTreeControl<Meta>(node => node.metas);
  dataSource = new MatTreeNestedDataSource<Meta>();
  homeKeyspaceVisible:boolean=false;
  tabsTableVisible:boolean=false;
  createKeyspaceVisible:boolean=false;
  addKeyspaceVisible:boolean=false;
  connectionClosedSubscription:Subscription;
  tableInfoSubscription:Subscription;
  metaKeyspaceSubscription:Subscription;
  errorClosedSubscription:Subscription;
  tableColumnsSubscription:Subscription;
  tableInfo:JSON;
  keyspaceInfoSubscription:Subscription;
  keyspaceRemovedSubscription:Subscription;
  tableRemovedSubscription:Subscription;
  keyspaceInfo:JSON;
  displayedColumns=['name','type','primaraKey','indexed'];
  displayedColumnsPrimary=['key'];
  displayedColumnsTableKeys=['tableName'];
  displayedColumnsIndex=['name','indexName'];
  colonneDataSource=new MatTableDataSource<JSON>();
  currentTableKeys:string[];
  selectedPageIndex=0;
  selectedKeysPageIndex=0;
  currentNodeId:string='';
  currentConnection:ConnectionDTO;
  currentKeyspaceName:string;
  columnsSize:number;
  keyspaceForm:FormGroup; 
  hasChild = (_: number, node: Meta) => !!node.metas && node.metas.length > 0;
  constructor(private gaindeService:GaindeService,private router:Router,private formBuilder:FormBuilder,
   private snackBar:MatSnackBar,private dialog: MatDialog) {
      
    }

  ngOnInit() {
    this.currentConnection=this.gaindeService.currentConnection;
    if(this.gaindeService.currentMetaConnection){
      this.dataSource.data=this.gaindeService.currentMetaConnection;
      this.homeKeyspaceVisible=true;  
      /*for (let i = 0; i < this.gaindeService.currentMetaConnection.length; i++) {
        this.treeControl.expand(this.gaindeService.currentMetaConnection[i])
      } */ 
    }
    this.connectionClosedSubscription=this.gaindeService.connectionClosedSubject.subscribe((result: boolean) => {     
      if(result){
        this.router.navigate(['/viewConnections']);
      }
    });
    this.errorClosedSubscription=this.gaindeService.errorConnectionCloseSubject.subscribe((result: string) => {    
     
    });
    this.keyspaceRemovedSubscription=this.gaindeService.removeKeyspaceSubject.subscribe((result: string) => {    
      this.openSnackBar('Le keyspace '+result+' a été ajouté supprimée','');
    });
    this.tableRemovedSubscription=this.gaindeService.removeTableSubject.subscribe((result: string) => {    
      this.openSnackBar('La table '+result+' a été ajouté supprimée','');
    });
    this.tableInfoSubscription=this.gaindeService.tableInfoSubject.subscribe((result: JSON) => {    
     this.tableInfo=result;
     this.colonneDataSource.data=this.tableInfo['columns']; 
     this.columnsSize=this.tableInfo['columns'].length;   
     this.tabsTableVisible=true;
     if(this.gaindeService.currentMetaConnection && this.currentKeyspaceName) {
      for (let i = 0; i < this.gaindeService.currentMetaConnection.length; i++) {
        if(this.gaindeService.currentMetaConnection[i]['name']===this.currentKeyspaceName)
          {
            this.treeControl.expand(this.gaindeService.currentMetaConnection[i]);           
            
          }
      } 
     
    }
     

    });  
    this.metaKeyspaceSubscription=this.gaindeService.keyspaceMetaSubject.subscribe((keyspaceMeta: any) => {
      this.dataSource.data=keyspaceMeta;   
      this.gaindeService.currentMetaConnection= keyspaceMeta;
      if(this.gaindeService.currentMetaConnection && this.currentKeyspaceName) {
        for (let i = 0; i < this.gaindeService.currentMetaConnection.length; i++) {
          if(this.gaindeService.currentMetaConnection[i]['name']===this.currentKeyspaceName)
            {
              this.treeControl.expand(this.gaindeService.currentMetaConnection[i]);
              this.currentNodeId=this.gaindeService.currentMetaConnection[i]['id'];
              
            }
        }  
        this.openSnackBar('Le keyspace '+this.currentKeyspaceName+' a été ajouté avec succès','');
        this.addKeyspaceVisible=false;
      }
      
    });
    this.keyspaceInfoSubscription=this.gaindeService.keyspaceInfoSubject.subscribe((result: JSON) => {    
     this.keyspaceInfo=result;
     console.log('keyspaceInfoSubscription  : ' + JSON.stringify(this.keyspaceInfo));
     this.createKeyspaceVisible=true;
    });
     
  }
  openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, {
      duration: 100000,
      // here specify the position
      verticalPosition: 'top',
      panelClass: ['green-snackbar']
    });
}
  private initForm(){
    this.keyspaceForm = this.formBuilder.group({    
      name: ['',Validators.required],
      strategy: ['',Validators.required],
      replication: ['',Validators.required],
      durableWrite:[true]
     
    });
  }
  onClickCloseConnection(){
    if(this.currentConnection){
      let name:string=this.currentConnection['name'];
      this.gaindeService.closeConnection(name);
    }
  }
  onClickRowNode(node){
    //console.log('onClickRowNode  : ' + JSON.stringify(node));
    this.currentNodeId=node['id']; 
    if(node['type']===1){
      this.tabsTableVisible=false;
      this.addKeyspaceVisible=false;
      this.currentTableKeys=node['id'].split("#");
      this.gaindeService.getKeyspaceInfo(this.currentTableKeys[0],this.currentTableKeys[1]);
    }else{       
      this.currentTableKeys=node['id'].split("#");
      this.gaindeService.getInfoTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      if(this.selectedPageIndex==1) 
      {
        this.selectedPageIndex=0;
      }
    }
  }
  onClickRemoveKeyspaceOrTable(node){
    //console.log('onClickRowNode  : ' + JSON.stringify(node));
    this.currentNodeId=node['id']; 
    this.currentTableKeys=this.currentNodeId.split("#");
    if(node['type']===1){
      this.tabsTableVisible=false;
      this.openDialog('Confirmation de suppression',"Voulez-vous supprimer le keyspace "+this.currentTableKeys[1]+"?",true,this.currentNodeId);
    }else{       
      this.openDialog('Confirmation de suppression',"Voulez-vous supprimer la table "+this.currentTableKeys[2]+"?",true,this.currentNodeId);
    }
  }
  
  onClickAddKeyspace(){
    this.tabsTableVisible=false;
    this.initForm();
    this.createKeyspaceVisible=true;
    this.addKeyspaceVisible=true;
  }
  onClickSaveKeyspace(){
    let  keyspaceDTO=new KeyspaceDTO(this.keyspaceForm.value['name'],this.keyspaceForm.value['strategy'],
    this.keyspaceForm.value['replication'], this.keyspaceForm.value['durableWrite']);  
    this.currentKeyspaceName=this.keyspaceForm.value['name'];  
    this.gaindeService.saveKeyspace(this.currentConnection['name'],keyspaceDTO);
  }
  onClickShowTabColonne(){
      console.log('onClickShowTabColonne  : ' + JSON.stringify(this.currentTableKeys));  
      console.log('onClickShowTabColonne event : ' + this.selectedPageIndex);  
      if(this.currentTableKeys && this.selectedPageIndex==1){
        this.gaindeService.getAllDatas(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      }   
  }
  onClickRowTable(row){
    console.log('onClickRowTable  : '+row);
    this.currentNodeId=row;
    this.currentTableKeys=row.split("#");
    this.currentKeyspaceName=this.currentTableKeys[1];
    this.gaindeService.getInfoTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
    if(this.selectedPageIndex==1) 
    {
      this.selectedPageIndex=0;
    }
  }
  onClickShowKeyspace(){
   
  }
  openDialog(pTitle:string,pText:string, cancelButton:boolean,pId:string): void {
    const dialogRef = this.dialog.open(DialogInfoKeyspaceComponent, {
      width: '500px',
      data: {text: pText,title:pTitle,btnCancel:cancelButton,id:pId}
    });

    dialogRef.afterClosed().subscribe(result => {     
      if(result!=null && result.length>1){
        console.log('keyspaceInfoSubscription  : ' + result);
        this.currentTableKeys=result.split("#");
        this.currentNodeId=result;
        if(this.currentTableKeys.length==2){
            this.gaindeService.removeKeySpace(this.currentTableKeys[0],this.currentTableKeys[1]); 
        }else{
           this.gaindeService.removeTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]); 
        }
      }

    });
  }
}

@Component({
  selector: 'app-dialog-info-connection',
  templateUrl: './dialog-info-keyspace.component.html' ,
  styleUrls: ['./view-keyspace.component.scss']
})
export class DialogInfoKeyspaceComponent implements OnInit {

  constructor( public dialogRef: MatDialogRef<ViewKeyspaceComponent>,@Inject(MAT_DIALOG_DATA) public data: DialogData) { }

  ngOnInit() {
  }

}
