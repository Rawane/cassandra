import { Component, OnInit,OnDestroy,Inject,ViewChild } from '@angular/core';
import {FormGroup,FormBuilder,Validators} from '@angular/forms'; 
import { DatePipe } from '@angular/common';
import {Router} from '@angular/router';
import {Subscription,Subject} from 'rxjs';
import {NestedTreeControl} from '@angular/cdk/tree';
import {MatTreeNestedDataSource} from '@angular/material/tree';
import {MatTableDataSource} from '@angular/material/table';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {MatDialog, MatDialogRef,MAT_DIALOG_DATA} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import {GaindeService} from '../services/gainde.service';
import {ConnectionDTO,KeyspaceDTO,ActionHttp,VIEW_ECRAN} from '../model/model-dto';
import{DialogData} from '../view-connections/view-connections.component';

interface Meta {
  name:string; 
  metas:Meta[];
}
@Component({
  selector: 'app-view-keyspace',
  templateUrl: './view-keyspace.component.html',
  styleUrls: ['./view-keyspace.component.scss']
})
export class ViewKeyspaceComponent implements OnInit,OnDestroy {
  treeControl = new NestedTreeControl<Meta>(node => node.metas);
  dataSource = new MatTreeNestedDataSource<Meta>();
  partVisible:VIEW_ECRAN;
  homeKeyspaceVisible:boolean=false;
  allNotificationSubscription:Subscription;
  @ViewChild(MatPaginator, {static: false}) paginator: MatPaginator;
  @ViewChild(MatSort, {static: false}) sort: MatSort;
  tableInfo:JSON;
  keyspaceInfo:JSON;
  tableKeyspaceInfoDataSource=new MatTableDataSource<JSON>();
  displayedColumns=['name','type','partitionKey','indexed'];
  displayedColumnsPrimary=['key'];
  displayedColumnsTableKeys=['tableName','tableAction','actionremove'];
  displayedColumnsIndex=['name','indexName'];
  displayedColumnsTableData: string[];
  dispColumnsHeadTableData;
  colonneDataSource=new MatTableDataSource<JSON>();
  tableDatasDataSource=new MatTableDataSource<JSON>();
  filterTableData='';
  filterTableKeyspaceData='';
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
  zoomData=false;
  notificationDialogSubject=new Subject<any>();
  hasChild = (_: number, node: Meta) => !!node.metas && node.metas.length > 0;
  constructor(private gaindeService:GaindeService,private router:Router,private formBuilder:FormBuilder,
   private snackBar:MatSnackBar,private dialog: MatDialog) {
      
    }
initEcranWithCurrentData(){
  if(this.gaindeService.currentGainde.content){
    this.dataSource.data=this.gaindeService.currentGainde.content;
    let content=this.gaindeService.currentGainde.content;
    let kName=this.gaindeService.currentGainde.keyspaceName;
    this.homeKeyspaceVisible=true;    
    if(kName){
        for (let i = 0; i < content.length; i++) {
          if (content[i]['name'] === kName) {
            this.treeControl.expand(content[i]);
            this.currentNodeId = content[i]['id'];
            let tableName=this.gaindeService.currentGainde.tableName;
            let connectionName=this.gaindeService.currentGainde.connectionName;
            if(tableName){
              this.currentNodeId = content[i]['id']+'#'+tableName;
              let verif:boolean=false;
              for(let tableK of content[i]['metas']){
                if(tableK['id']==this.currentNodeId){
                  verif=true;
                  break;
                }
              }if(!verif){
                  content[i]['metas'].push({"name":tableName,id:this.currentNodeId,"type":2,"metas":[]});                 
              }
              this.gaindeService.getInfoTable(connectionName,kName,tableName);
              this.currentTableKeys=this.currentNodeId.split("#");
            }
            break;
          }
        }
    }
  }
}
emitNotificationDialogSubject(content:any) {
  this.notificationDialogSubject.next(content);
}
  ngOnInit() {
    this.currentConnection=this.gaindeService.currentGainde.connection;
   this.initEcranWithCurrentData();

    this.allNotificationSubscription=this.gaindeService.mapTransfertViewKeyspaceSubject.subscribe((mapTransfert: Map<string,any>) => {
      let mapToString='';
      mapTransfert.forEach((key,item)=>{
        mapToString=mapToString+' '+item+'  value='+JSON.stringify(mapTransfert.get(item));        
      });   
     console.log('ViewKeyspaceComponent mapTransfert '+mapTransfert.get("type"));  
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
                this.gaindeService.currentGainde.content=mapTransfert.get('content');
                this.dataSource.data=this.gaindeService.currentGainde.content;
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
              this.gaindeService.currentGainde.content=mapTransfert.get('content');
              let content=this.gaindeService.currentGainde.content;
              this.dataSource.data=content;
              this.openSnackBar('La table a été supprimée','');
              let kName=this.gaindeService.currentGainde.keyspaceName;
              let connectionName=this.gaindeService.currentGainde.connectionName;
              this.gaindeService.getKeyspaceInfo(connectionName,kName);
              
              if(kName){
                for (let i = 0; i < content.length; i++) {
                  if (content[i]['name'] === kName) {
                    this.treeControl.expand(content[i]);
                    this.currentNodeId = content[i]['id'];                
                    break;
                  }
                }
            }
             
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
                this.tableKeyspaceInfoDataSource.data=mapTransfert.get('content')['tables'];
                this.tableKeyspaceInfoDataSource.filter = '';               
                this.filterTableKeyspaceData='';
                this.partVisible=VIEW_ECRAN.KEYSPACE_INFO;
                //console.log('INFO_KEYSPACE  : ' + JSON.stringify(this.keyspaceInfo));
                break;   
            }
            case ActionHttp.INFO_KEYSPACE_ERROR: 
            {               
                this.openDialog('INFO Keyspace',mapTransfert.get("content"),false,'');
                break;  
            }
            case ActionHttp.ALL_DATA_TABLE:              
            { 
              this.doAfterGetAllData(mapTransfert);
              break;
            }
            case ActionHttp.ALL_DATA_TABLE_ERROR: 
            {               
                this.openDialog('Table ',mapTransfert.get("content"),false,'');
                break;  
            } 
      case ActionHttp.INSERT_DATA_TABLE:              
        { let connectionName=this.gaindeService.currentGainde.connectionName;
          let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
          this.openSnackBar('Données insérées avec succès','');
          this.emitNotificationDialogSubject({'errorDialog':false,'data':mapTransfert.get("content")});
          this.gaindeService.getAllDataTable(connectionName,keyspaceName,mapTransfert.get("content"));
          break;
        }
      case ActionHttp.INSERT_DATA_TABLE_ERROR: 
      {     
          this.emitNotificationDialogSubject({'errorDialog':true,'data':mapTransfert.get("content")});
          break;  
      }
      case ActionHttp.UPDATE_DATA_TABLE:              
        { let connectionName=this.gaindeService.currentGainde.connectionName;
          let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
          this.openSnackBar('Données mis à jour avec succès','');
          //this.dialog.closeAll();
          this.emitNotificationDialogSubject({'errorDialog':false,'data':mapTransfert.get("content")});
         
          this.gaindeService.getAllDataTable(connectionName,keyspaceName,mapTransfert.get("content"));         
          break;
        }
        case ActionHttp.UPDATE_DATA_TABLE_ERROR: 
      {       
         this.emitNotificationDialogSubject({'errorDialog':true,'data':mapTransfert.get("content")});
          break;  
      }           
            default:
              break;
         }
      });     
  }
  ngOnDestroy() {
    this.allNotificationSubscription.unsubscribe();
  }
  private doAfterGetAllData(mapTransfert: Map<string, any>) {
    if (mapTransfert.get("content")['columns']) {
      this.displayedColumnsTableData = [];
      mapTransfert.get("content")['columns'].forEach(col => {
        //console.log('columns ' + JSON.stringify(col));
        this.displayedColumnsTableData.push(col['name']);
      });
      this.displayedColumnsTableData.push('action_gainde');
    }
    this.dispColumnsHeadTableData = mapTransfert.get("content")['columns'];
   // console.log('displayedColumnsTableData ' + JSON.stringify(this.displayedColumnsTableData));
   // console.log('dispColumnsHeadTableData ' + JSON.stringify(this.dispColumnsHeadTableData));
    this.tableDatasDataSource.data = mapTransfert.get("content")['data'];
    this.paginationTableDataSize = mapTransfert.get("content")['data'].length;
    this.tableDatasDataSource.paginator = this.paginator;
    this.tableDatasDataSource.sort = this.sort;
    this.tableDatasDataSource.filter = '';
    this.filterTableData = '';
    this.tableDatasDataSource.sortingDataAccessor = (item, property) => {
      //console.log(item)
      switch (property) {
        case 'fromDate': {
          return new Date(item['timestamp'] * 1000);
        }
        default: return item[property];
      }
    };
  }

  onApplyFilter(filterValue: string) {
    this.tableDatasDataSource.filter = filterValue.trim().toLowerCase();
    if (this.tableDatasDataSource.paginator) {
        this.tableDatasDataSource.paginator.firstPage();
    }
  }
  onApplyFilterTableKeyspace(filterVal: string) {
    console.log('onApplyFilterTableKeyspace '+filterVal);
    this.tableKeyspaceInfoDataSource.filter = filterVal.trim().toLowerCase();     
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
    this.treeControl.expand(node);   
    this.currentTableKeys=node['id'].split("#");
    this.gaindeService.currentGainde.connectionName =this.currentTableKeys[0];
    this.gaindeService.currentGainde.keyspaceName =this.currentTableKeys[1];  
    if(node['type']===1){
      this.partVisible=VIEW_ECRAN.KEYSPACE_INFO;     
      this.gaindeService.getKeyspaceInfo(this.currentTableKeys[0],this.currentTableKeys[1]);      
    }else{      
      this.gaindeService.currentGainde.tableName =this.currentTableKeys[2];  
      this.gaindeService.getInfoTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      if(this.selectedPageIndex==1) 
      {
        //this.selectedPageIndex=0;
        if(this.currentTableKeys){
          this.gaindeService.getAllDataTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
        }  
      }else{

      }
    }
  }
  onClickNavigateTab(){
    console.log('onClickNavigateTab  : ' + this.selectedPageIndex);
    if(this.selectedPageIndex==1){
      if(this.currentTableKeys){
        this.gaindeService.getAllDataTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      }  
    }
    
  }

  onClickEditRow(row,name){
    //console.log('onClickEditRow  : ' + JSON.stringify(row)); 
    //row['columns']=this.dispColumnsHeadTableData;
    let data:any={'columns':this.dispColumnsHeadTableData,
    'tableName':name,'row':row,'added':false};
    //let indexElement= this.tableDatasDataSource.data.indexOf(row);
   // console.log('onClickEditRow  : '+  JSON.stringify(data));
    this.openDialogRow(data);
    
  }
  onClickAddNewRow(name){
    console.log('onClickEditRow  : ' + name); 
    let row:any={};
    this.dispColumnsHeadTableData.forEach(eltD=>{
      row[eltD.name]="";
    });
    let data:any={"columns":this.dispColumnsHeadTableData,
    "tableName":name,'row':row,"added":true}; 
    this.openDialogRow(data);
  }
  onClickRemoveKeyspaceOrTable(node){
    //console.log('onClickRowNode  : ' + JSON.stringify(node));
    this.currentNodeId=node['id']; 
    this.currentTableKeys=this.currentNodeId.split("#");
    this.gaindeService.currentGainde.connectionName =this.currentTableKeys[0];
    this.gaindeService.currentGainde.keyspaceName =this.currentTableKeys[1]; 
    if(node['type']===1){
      this.partVisible=VIEW_ECRAN.KEYSPACE_HOME;
      this.currentKeyspaceName=this.currentTableKeys[1];
      this.openDialog('Confirmation de suppression',"Voulez-vous supprimer le keyspace "+this.currentTableKeys[1]+"?",true,this.currentNodeId);
    }else{  
      this.currentKeyspaceName=this.currentTableKeys[1];    
      //this.gaindeService.currentGainde.tableName =this.currentTableKeys[2];  
      this.openDialog('Confirmation de suppression',"Voulez-vous supprimer la table "+this.currentTableKeys[2]+" du keyspace"+this.currentTableKeys[1]+"?",true,this.currentNodeId);
    }
  }
  onClickRemoveTable(connectionName:string,keyspaceName:string,tableName:string){
    //console.log('onClickRowNode  : ' + JSON.stringify(node));
    let key:string=connectionName+'#'+keyspaceName+'#'+tableName;
    this.currentKeyspaceName=keyspaceName;   
    this.gaindeService.currentGainde.connectionName =connectionName;
    this.gaindeService.currentGainde.keyspaceName =keyspaceName; 
    this.openDialog('Confirmation de suppression',"Voulez-vous supprimer la table "+tableName+" du keyspace "+keyspaceName+"?",true,key);
  }
  onClickAddKeyspace(){    
    this.initForm();
    this.partVisible=VIEW_ECRAN.KEYSPACE_NEW;
    this.zoomData=false;
  }
  onClickSaveKeyspace(){
    let  keyspaceDTO=new KeyspaceDTO(this.keyspaceForm.value['name'],this.keyspaceForm.value['strategy'],
    this.keyspaceForm.value['replication'], this.keyspaceForm.value['durableWrite'],this.keyspaceForm.value['dataCenter']);  
    this.currentKeyspaceName=this.keyspaceForm.value['name'];  
    this.keyspaceInfo=JSON.parse(JSON.stringify(keyspaceDTO));
    this.keyspaceInfo['tables']=[];
    this.gaindeService.saveKeyspace(this.currentConnection['name'],keyspaceDTO);
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
    console.log('onClickAddNewTable connectionName='+connectionName+' keyspace '+keyspaceName);
    this.gaindeService.currentGainde.connectionName=connectionName;
    this.gaindeService.currentGainde.keyspaceName=keyspaceName;  
    this.gaindeService.currentGainde.tableName=null;   
    this.openDialogTableInfo(5);    
  }
  onClickEditTable(connectionName:string,keyspaceName:string,tableName:string){
    console.log('onClickEditTable connectionName='+connectionName+' keyspace '+keyspaceName+' table name '+tableName);   
    this.gaindeService.currentGainde.connectionName=connectionName;
    this.gaindeService.currentGainde.keyspaceName=keyspaceName;  
    this.gaindeService.currentGainde.tableName=tableName; 
    this.router.navigate(['/editTable']);
  }
  onClickEditCurrentTable(){    
    console.log('onClickEditTableView ='+JSON.stringify(this.currentTableKeys));   
    this.gaindeService.currentGainde.connectionName=this.currentTableKeys[0];
    this.gaindeService.currentGainde.keyspaceName=this.currentTableKeys[1];  
    this.gaindeService.currentGainde.tableName=this.currentTableKeys[2]; 
    this.router.navigate(['/editTable']);
  }
  onClickShowKeyspace(){
   
  }
  onStrategyChange(){
    this.keyspaceForm.get('strategy').valueChanges.subscribe(val => {
      if(val==='SimpleStrategy'){
        this.keyspaceForm.get('replication').setValidators([Validators.required]);
      }else{
        this.keyspaceForm.get('replication').setValidators([]);
      }
    });
  }
  onZoomTable(){ 
    this.zoomData=!this.zoomData;
    console.log('onZoomTable  : ' + this.zoomData);
  }
   openDialog(pTitle:string,pText:string, cancelButton:boolean,pId:string): void {
    let dialogRef = this.dialog.open(DialogInfoKeyspaceComponent, {
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
      dialogRef=null;
    });
    
  }
  
  private openDialogTableInfo(counter:number): void {
    let dialogRefTableInfo = this.dialog.open(DialogTableColumnInfoComponent, {
      width: '500px',
     
      data: {counter: counter}
    });
  
    dialogRefTableInfo.afterClosed().subscribe(result => {     
      
      if(result!=null){
       console.log("openDialogTableInfo "+result);
       this.gaindeService.currentGainde.counter=result;
       this.router.navigate(['/addTable']);
      dialogRefTableInfo=null;
      }

    });
  }
  private openDialogRow(row:JSON): void {
    let dialogRefRow = this.dialog.open(DialogEditRowComponent, {
      width: 'auto',     
      data: row,
      panelClass: 'customDialogEdit'
    });  
    dialogRefRow.componentInstance.setGaindeService(this.gaindeService);  
    dialogRefRow.componentInstance.setComponent(this);
    dialogRefRow.afterClosed().subscribe(result => {    
      
      dialogRefRow=null;

    });
  }
  
  private doAfterGetInfoTable(mapTransfert: Map<string, any>) {    
    this.tableInfo = mapTransfert.get('content');
    this.colonneDataSource.data = this.tableInfo['columns'];
    this.columnsSize = this.tableInfo['columns'].length;
    this.partVisible=VIEW_ECRAN.KEYSPACE_INFO_TABLE;
    if (this.gaindeService.currentGainde.content && this.currentKeyspaceName) {
      for (let i = 0; i < this.gaindeService.currentGainde.content.length; i++) {
        if (this.gaindeService.currentGainde.content[i]['name'] === this.currentKeyspaceName) {
          this.treeControl.expand(this.gaindeService.currentGainde.content[i]);
        }
      }
    }
  }

  private doAfterSaveKeyspace(mapTransfert: Map<string, any>) {
    this.dataSource.data = mapTransfert.get('content');
    this.gaindeService.currentGainde.content = mapTransfert.get('content');
    let content=this.gaindeService.currentGainde.content;
    if (content && this.currentKeyspaceName) {
      for (let i = 0; i < content.length; i++) {
        if (content[i]['name'] === this.currentKeyspaceName) {
          this.treeControl.expand(content[i]);
          this.currentNodeId = content[i]['id'];
        }
      }
      this.openSnackBar('Le keyspace ' + this.currentKeyspaceName + ' a été ajouté avec succès', '');
      this.partVisible=VIEW_ECRAN.KEYSPACE_INFO;
    }
  }

 public openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, {
      duration: 2000,
      // here specify the position
      verticalPosition: 'top',
      panelClass: ['green-snackbar']
    });
}
  private initForm(){
    this.keyspaceForm = this.formBuilder.group({    
      name: ['',Validators.required],
      strategy: ['',Validators.required],
      replication: [''],
      durableWrite:[true],
      dataCenter:[]
     
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

@Component({
  selector: 'app-dialog-table-column',
  templateUrl: './dialog-table-column-info.component.html' ,
  styleUrls: ['./view-keyspace.component.scss']
})
export class DialogTableColumnInfoComponent implements OnInit {

  constructor( public dialogRef: MatDialogRef<ViewKeyspaceComponent>,@Inject(MAT_DIALOG_DATA) public data: DialogData) { }

  ngOnInit() {
  }

}
@Component({
  selector: 'app-dialog-row-column',
  templateUrl: './dialog-edit-row.component.html' ,
  styleUrls: ['./view-keyspace.component.scss'],
  providers: [DatePipe
    ]
})
export class DialogEditRowComponent implements OnInit {
private gaindeService:GaindeService;
private viewParent:ViewKeyspaceComponent;
messageError:string='';
error:boolean=false;
notificationSubscription:Subscription;
setColumns = new Set<string>();  
  constructor( public dialogRef: MatDialogRef<ViewKeyspaceComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, private snackBar:MatSnackBar,
    private datePipe: DatePipe) { }

  ngOnInit() {
    this.notificationSubscription=this.viewParent.notificationDialogSubject.subscribe((content:any) => {
      console.log("notificationSubscription "+JSON.stringify(content));
      if(content['errorDialog']){
        this.messageError="Une erreur non spécifié s'est produite";
        if(content['data'] && content['data']){
           this.messageError=content['data'] ; 
        }  
        this.error=true;  
      }else{
           this.dialogRef.close();
      }
    });
  
  }
  onClickSaveData(data:any){  
    this.messageError= '';
    this.error=false;  
    if(data!=null){
     // console.log("openDialogTableInfo "+JSON.stringify(data));
      let connectionName=this.gaindeService.currentGainde.connectionName;
      let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
      if(data['added']){
        let requestData:any={};
         requestData['data']={};
         data['columns'].forEach(col=>{        
          if(col.type=='DATE')
          { 
            requestData['data'][col.name]={'data':this.datePipe.transform(data['row'][col.name],'dd/MM/yyyy'),'type':col.type};
          }else{
            requestData['data'][col.name]={'data':data['row'][col.name],'type':col.type};
          }
          } );    
         this.gaindeService.insertDataTable(requestData,connectionName,keyspaceName,data['tableName']);
      }else{
        let partitionKeys:string[]=[];
        let requestData:any={};
        requestData['data']={};
        let mapTemp=new Map<string,string>();
        data['columns'].forEach(col=>{
           if(col['partitionKey']){
             partitionKeys.push(col.name);
             requestData['data'][col.name]={'data':data['row'][col.name],'type':col.type};
           }else{
            mapTemp.set(col.name,col.type);
           }
        });       
        this.setColumns.forEach(colName=>{
          if(mapTemp.get(colName)=='DATE')
          {
            requestData['data'][colName]={'data':this.datePipe.transform(data['row'][colName],'dd/MM/yyyy'),'type':mapTemp.get(colName)};
          }else{
            requestData['data'][colName]={'data':data['row'][colName],'type':mapTemp.get(colName)};
          }
        });
        requestData['partitionKeys']=partitionKeys;
       this.gaindeService.updateDataTable(requestData,connectionName,keyspaceName,data['tableName']);
      }
     }
  }
  setGaindeService(gaindeService:GaindeService){
    this.gaindeService=gaindeService;
  }
  setComponent(viewParent:ViewKeyspaceComponent){
    this.viewParent=viewParent;
  }
  closeDialog(){
    this.dialogRef.close();
  }
  onValueChange(name:any,value:any){    
    this.setColumns.add(name);
    console.log("onValueChange "+name+" value "+value);
  }
  onValueChangeDate(name:any,value:Date){    
    this.setColumns.add(name);
    console.log("onValueChange "+name+" value "+value);
  }
  public openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, {
      duration: 2000,     
      verticalPosition: 'top',
      panelClass: ['green-snackbar']
    });
}
}

