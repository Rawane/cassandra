import { Component, OnInit,Inject,ViewChild } from '@angular/core';
import {FormGroup,FormBuilder,Validators} from '@angular/forms'; 
import {Router} from '@angular/router';
import {Subscription} from 'rxjs';
import {NestedTreeControl} from '@angular/cdk/tree';
import {MatTreeNestedDataSource} from '@angular/material/tree';
import {MatTableDataSource} from '@angular/material/table';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {MatDialog, MatDialogRef,MAT_DIALOG_DATA} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import {GaindeService} from '../services/gainde.service';
import {ConnectionDTO} from '../model/connection-dto';
import {KeyspaceDTO} from '../model/keyspace-dto';
import{DialogData} from '../view-connections/view-connections.component';
import {ActionHttp} from '../model/action-http';
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
  allNotificationSubscription:Subscription;
  @ViewChild(MatPaginator, {static: false}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: false}) sort: MatSort;
  tableInfo:JSON;
  keyspaceInfo:JSON;
  displayedColumns=['name','type','primaraKey','indexed'];
  displayedColumnsPrimary=['key'];
  displayedColumnsTableKeys=['tableName','tableAction'];
  displayedColumnsIndex=['name','indexName'];
  displayedColumnsTableData: string[];
  colonneDataSource=new MatTableDataSource<JSON>();
  tableDatasDataSource=new MatTableDataSource<JSON>();
  bigTable:boolean=false;
  currentTableKeys:string[];
  selectedPageIndex=0;
  selectedKeysPageIndex=0;
  currentNodeId:string='';
  currentConnection:ConnectionDTO;
  currentKeyspaceName:string;
  columnsSize:number;
  keyspaceForm:FormGroup; 
  paginationTableDataSize;
  hasChild = (_: number, node: Meta) => !!node.metas && node.metas.length > 0;
  constructor(private gaindeService:GaindeService,private router:Router,private formBuilder:FormBuilder,
   private snackBar:MatSnackBar,private dialog: MatDialog) {
      
    }

  ngOnInit() {
    this.currentConnection=this.gaindeService.currentConnection;
    if(this.gaindeService.currentMetaConnection){
      this.dataSource.data=this.gaindeService.currentMetaConnection;
      this.homeKeyspaceVisible=true;      
    }


    this.allNotificationSubscription=this.gaindeService.mapTransfertSubject.subscribe((mapTransfert: Map<string,any>) => {
      let mapToString='';
      mapTransfert.forEach((key,item)=>{
        mapToString=mapToString+' '+item+'  value='+JSON.stringify(mapTransfert.get(item));        
      });   
      console.log('ViewKeyspaceComponent mapTransfert '+mapToString);  
      switch (mapTransfert.get("type") as ActionHttp)  {
            case ActionHttp.CLOSE_CONNECTION:
            {
                this.router.navigate(['/viewConnections']);
                break;
            }
            case ActionHttp.CLOSE_CONNECTION_ERROR:
            {
                this.openDialog('Connection',"Erreur lors de la fermiture de la connection",false,'');
                break;
            }
            case ActionHttp.REMOVE_KEYSPACE:
            {
                this.gaindeService.currentMetaConnection=mapTransfert.get('content');
                this.dataSource.data=this.gaindeService.currentMetaConnection;
                this.openSnackBar('Le keyspace  a été  supprimée','');
                break;
            }               
            case ActionHttp.REMOVE_KEYSPACE_ERROR:  
            {              
                this.openDialog('Suppression Keyspace',mapTransfert.get("content"),false,'');
                break;
            }
            case ActionHttp.REMOVE_TABLE:
            {
              this.gaindeService.currentMetaConnection=mapTransfert.get('content');
              this.dataSource.data=this.gaindeService.currentMetaConnection;
              this.openSnackBar('La table a été supprimée','');
              break;
            }
            case ActionHttp.REMOVE_TABLE_ERROR:
            {
                this.openDialog('Suppression Table',mapTransfert.get("content"),false,'');
                break;
            }
            case ActionHttp.INFO_TABLE:
            {
                this.doAfterGetInfoTable(mapTransfert);
                break;
            }
            case ActionHttp.INFO_TABLE_ERROR:
            {
                  this.openDialog('Erreur de Connection',mapTransfert.get("content"),false,'');
                  break;
            }
            case ActionHttp.SAVE_KEYSPACE:
            {
                this.doAfterSaveKeyspace(mapTransfert);
                break;  
              }        
            case ActionHttp.SAVE_KEYSPACE_ERROR:
            {                
                this.openDialog('Keyspace',mapTransfert.get("content"),false,'');
                break;   
            }
            case ActionHttp.INFO_KEYSPACE: 
            {               
                this.keyspaceInfo=mapTransfert.get('content');
                this.createKeyspaceVisible=true;
                console.log('INFO_KEYSPACE  : ' + JSON.stringify(this.keyspaceInfo));
                break;   
            }
            case ActionHttp.INFO_KEYSPACE_ERROR: 
            {               
                this.openDialog('INFO Keyspace',mapTransfert.get("content"),false,'');
                break;  
            }
            case ActionHttp.ALL_DATA_TABLE:              
            { 
              this.displayedColumnsTableData=mapTransfert.get("content")['columns'];
              console.log('displayedColumnsTableData '+JSON.stringify(this.displayedColumnsTableData));
              this.tableDatasDataSource.data=mapTransfert.get("content")['data'];
              this.paginationTableDataSize=mapTransfert.get("content")['data'].length;
              console.log('data '+ this.tableDatasDataSource.data[0]['keyspace_name']);
              this.tableDatasDataSource.paginator = this.paginator;
              this.tableDatasDataSource.sort = this.sort;      
              this.tableDatasDataSource.sortingDataAccessor = (item, property) => {
                //console.log(item)
                switch (property) {
                  case 'fromDate': {
                    return new Date(item['timestamp']*1000);
                  }
                  default: return item[property];
                }
              };
              break;
            }
            case ActionHttp.ALL_DATA_TABLE_ERROR: 
            {               
                this.openDialog('Table ',mapTransfert.get("content"),false,'');
                break;  
            }
            default:
              break;
         }
      });     
  }
  applyFilter(filterValue: string) {
    this.tableDatasDataSource.filter = filterValue.trim().toLowerCase();
    if (this.tableDatasDataSource.paginator) {
        this.tableDatasDataSource.paginator.firstPage();
    }
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
        this.gaindeService.getAllDataTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
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
  onClickAddNewTable(connectionName:string,keyspaceName:string){
    this.router.navigate(['/editTable']);
  }
  onClickEditTable(connectionName:string,keyspaceName:string,tableName:string){
    this.router.navigate(['/editTable']);
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
  private doAfterGetInfoTable(mapTransfert: Map<string, any>) {
    this.tableInfo = mapTransfert.get('content');
    this.colonneDataSource.data = this.tableInfo['columns'];
    this.columnsSize = this.tableInfo['columns'].length;
    this.tabsTableVisible = true;
    if (this.gaindeService.currentMetaConnection && this.currentKeyspaceName) {
      for (let i = 0; i < this.gaindeService.currentMetaConnection.length; i++) {
        if (this.gaindeService.currentMetaConnection[i]['name'] === this.currentKeyspaceName) {
          this.treeControl.expand(this.gaindeService.currentMetaConnection[i]);
        }
      }
    }
  }

  private doAfterSaveKeyspace(mapTransfert: Map<string, any>) {
    this.dataSource.data = mapTransfert.get('content');
    this.gaindeService.currentMetaConnection = mapTransfert.get('content');
    if (this.gaindeService.currentMetaConnection && this.currentKeyspaceName) {
      for (let i = 0; i < this.gaindeService.currentMetaConnection.length; i++) {
        if (this.gaindeService.currentMetaConnection[i]['name'] === this.currentKeyspaceName) {
          this.treeControl.expand(this.gaindeService.currentMetaConnection[i]);
          this.currentNodeId = this.gaindeService.currentMetaConnection[i]['id'];
        }
      }
      this.openSnackBar('Le keyspace ' + this.currentKeyspaceName + ' a été ajouté avec succès', '');
      this.addKeyspaceVisible = false;
    }
  }

 private openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, {
      duration: 3000,
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
