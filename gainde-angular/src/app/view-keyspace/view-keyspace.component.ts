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
import {ConnectionDTO,KeyspaceDTO,ActionHttp,VIEW_ECRAN,ActionDialog} from '../model/model-dto';
import{DialogData} from '../view-connections/view-connections.component';
import {CdkDragStart, CdkDropList,CdkDragDrop, moveItemInArray} from '@angular/cdk/drag-drop';

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
  notifKeyspaceByDialog:Subscription;
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
  setColumnInvisible=new Set<string>();
  notificationDialogSubject=new Subject<any>();
  previousIndex: number;
  queryContent:string='';
  hasChild = (_: number, node: Meta) => !!node.metas && node.metas.length > 0;
  constructor(private gaindeService:GaindeService,private router:Router,private formBuilder:FormBuilder,
   private snackBar:MatSnackBar,private dialog: MatDialog) {
      
    }
    setDisplayedColumns() {      
      this.displayedColumnsTableData=[];
      this.dispColumnsHeadTableData.forEach(( colunm, index) => {
        colunm.index = index;
        this.displayedColumnsTableData[index] = colunm.name;
      });
      this.displayedColumnsTableData.push('action_gainde');
      this.displayedColumnsTableData.push('action_remove_gainde');
    }
    setDisplayedColumnsByNotif(columns:any) {      
     
      let arrayTemp=[...this.dispColumnsHeadTableData];
      this.displayedColumnsTableData=[];
      this.dispColumnsHeadTableData=[];
      columns.forEach(( colunm, index) => {        
        this.displayedColumnsTableData[index] = colunm.name;
        let indexCol:number;
        for(let i=0;i<arrayTemp.length;i++){
         if(arrayTemp[i].name==colunm.name){
          indexCol=i;
          break;
         }
        }
        this.dispColumnsHeadTableData[index]=arrayTemp[indexCol];
      });
      this.displayedColumnsTableData.push('action_gainde');
      this.displayedColumnsTableData.push('action_remove_gainde');
    }
  
    dragStarted(event: CdkDragStart, index: number ) {
      this.previousIndex = index;
      //console.log('dragStarted prev '+this.previousIndex);
    }
  
    dropListDropped(event: CdkDropList, index: number) {
      if (event) {
        console.log('dropListDropped prev '+this.previousIndex+'   new '+index);
        moveItemInArray(this.dispColumnsHeadTableData, this.previousIndex, index);
        //console.log('dropListDropped '+JSON.stringify(this.dispColumnsHeadTableData));
        this.setDisplayedColumns();
      }
    }
onExecuteQuery(){
  console.log("onExecuteQuery "+this.queryContent);
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
    this.notifKeyspaceByDialog=this.gaindeService.notifParentDialogKeyspace.subscribe((dataSource:any)=>{
    this.setDisplayedColumnsByNotif(dataSource);
});
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
                this.openDialog('Connection',"Erreur lors de la fermiture de la connection",false,'',ActionDialog.INFO);
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
                this.openDialog('Suppression Keyspace',mapTransfert.get("content"),false,'',ActionDialog.INFO);
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
                this.openDialog('Suppression Table',mapTransfert.get("content"),false,'',ActionDialog.INFO);
                break;
            }
            case ActionHttp.INFO_TABLE:
            {
                this.doAfterGetInfoTable(mapTransfert);
                break;
            }
            case ActionHttp.INFO_TABLE_ERROR:
            {
                  this.openDialog('Erreur de Connection',mapTransfert.get("content"),false,'',ActionDialog.INFO);
                  break;
            }
            case ActionHttp.SAVE_KEYSPACE:
            {
                this.doAfterSaveKeyspace(mapTransfert);
                break;  
              }        
            case ActionHttp.SAVE_KEYSPACE_ERROR:
            {                
                this.openDialog('Keyspace',mapTransfert.get("content"),false,'',ActionDialog.INFO);
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
                this.openDialog('INFO Keyspace',mapTransfert.get("content"),false,'',ActionDialog.INFO);
                break;  
            }
            case ActionHttp.ALL_DATA_TABLE:              
            { 
              this.doAfterGetAllData(mapTransfert);
              break;
            }
            case ActionHttp.ALL_DATA_TABLE_ERROR: 
            {               
                this.openDialog('Table ',mapTransfert.get("content"),false,'',ActionDialog.INFO);
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
              case ActionHttp.REMOVE_ONE_ROW: 
              {       
                this.openSnackBar('La ligne a été supprimée','');
                let connectionName=this.gaindeService.currentGainde.connectionName;
                let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
                this.gaindeService.getAllDataTable(connectionName,keyspaceName,mapTransfert.get("content"));
                break;  
              }  
              case ActionHttp.REMOVE_ALL_ROWS: 
              {       
                this.openSnackBar('Toutes les lignes ont été supprimées','');
                let connectionName=this.gaindeService.currentGainde.connectionName;
                let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
                this.gaindeService.getAllDataTable(connectionName,keyspaceName,mapTransfert.get("content"));
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
      this.displayedColumnsTableData.push('action_remove_gainde');
    }
    this.dispColumnsHeadTableData = mapTransfert.get("content")['columns'];
   
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
  onVerifyDisplay(columnName:string):boolean{   
    //console.log(columnName)
    return  this.setColumnInvisible.has(columnName);;
  }
  onShowSelectColumn(){
    this.openDialogSelectColumn();
  }
  onApplyFilter(filterValue: string) {
    this.tableDatasDataSource.filter = filterValue.trim().toLowerCase();
    if (this.tableDatasDataSource.paginator) {
        this.tableDatasDataSource.paginator.firstPage();
    }
  }
  onApplyFilterTableKeyspace(filterVal: string) {
    //console.log('onApplyFilterTableKeyspace '+filterVal);
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
      this.tableDatasDataSource.data=[];
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
      if(this.currentTableKeys && this.tableDatasDataSource.data.length==0){
        this.gaindeService.getAllDataTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      }  
    }
    
  }

  onClickEditRow(row,name){
    let data:any={'columns':this.dispColumnsHeadTableData,
    'tableName':name,'row':row,'added':false};
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
  onClickRemoveAllRow(tableName:string){
    let map=new Map<string,string>();
    map.set('gainDeTableName',tableName);
    this.openDialog('Confirmation de suppression',"Voulez-vous supprimer toutes lignes de la table  "+tableName+" du Keyspace "+this.currentTableKeys[1]+" ?",true,map,ActionDialog.ACTION_DELETE_ALL_RAWS); 
 }
  onClickRemoveRow(row:any,tableName:string){
    let map=new Map<string,string>();
    map.set('gainDeTableName',tableName);
    let parTiTionKey='';
    if(this.tableInfo['columns']){
      this.tableInfo['columns'].forEach(element => {
        if(element['partitionKey']){
          parTiTionKey=parTiTionKey+' '+element['name']+':'+row[element['name']];
          map.set(element['name'],row[element['name']]);
        }
      });
  }
    this.openDialog('Confirmation de suppression',"Voulez-vous supprimer la ligne avec la clé de partition "+parTiTionKey+" de la table "+tableName+"?",true,map,ActionDialog.ACTION_DELETE_ONE_ROW); 
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
      this.openDialog('Confirmation de suppression',"Voulez-vous supprimer le keyspace "+this.currentTableKeys[1]+"?",true,this.currentNodeId,ActionDialog.ACTION_DELETE_KEYSAPCE);
    }else{  
      this.currentKeyspaceName=this.currentTableKeys[1];    
      //this.gaindeService.currentGainde.tableName =this.currentTableKeys[2];  
      this.openDialog('Confirmation de suppression',"Voulez-vous supprimer la table "+this.currentTableKeys[2]+" du keyspace"+this.currentTableKeys[1]+"?",true,this.currentNodeId,ActionDialog.ACTION_DELETE_TABLE);
    }
  }
  onClickRemoveTable(connectionName:string,keyspaceName:string,tableName:string){
    //console.log('onClickRowNode  : ' + JSON.stringify(node));
    let key:string=connectionName+'#'+keyspaceName+'#'+tableName;
    this.currentKeyspaceName=keyspaceName;   
    this.gaindeService.currentGainde.connectionName =connectionName;
    this.gaindeService.currentGainde.keyspaceName =keyspaceName; 
    this.openDialog('Confirmation de suppression',"Voulez-vous supprimer la table "+tableName+" du keyspace "+keyspaceName+"?",true,key,ActionDialog.ACTION_DELETE_TABLE);
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
    this.tableDatasDataSource.data=[];
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
  onRefreshData(tableName:string){
    let connectionName=this.gaindeService.currentGainde.connectionName;
    let keyspaceName=this.gaindeService.currentGainde.keyspaceName;              
    this.gaindeService.getAllDataTable(connectionName,keyspaceName,tableName);
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
   openDialog(pTitle:string,pText:string, cancelButton:boolean,map:any,action:ActionDialog): void {
    let dialogRef = this.dialog.open(DialogInfoKeyspaceComponent, {
      width: '500px',
      data: {text: pText,title:pTitle,btnCancel:cancelButton,data:map,action:action}
    });
  
    dialogRef.afterClosed().subscribe(result => { 
      console.log('1 afterClosed '+JSON.stringify(result));
      if(result!=null){
        console.log('1 afterClosed '+JSON.stringify(result));
        switch (result['action'] as ActionDialog)  {
          case ActionDialog.ACTION_DELETE_KEYSAPCE:
          {
            this.currentTableKeys=result['data'].split("#");
            this.currentNodeId=result;
            if(this.currentTableKeys.length==2){
              this.gaindeService.removeKeySpace(this.currentTableKeys[0],this.currentTableKeys[1]); 
            }
            break;
          }
          case ActionDialog.ACTION_DELETE_TABLE:
          {
            this.currentTableKeys=result['data'].split("#");
            this.currentNodeId=result;
            if(this.currentTableKeys.length==3){
              this.gaindeService.removeTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]); 
            }
            break;
          }
          case ActionDialog.ACTION_DELETE_ONE_ROW:
          { 
            let map=result['data'] as Map<string,string>;
            let tableName=map.get('gainDeTableName');
            map.delete('gainDeTableName');
            let data={};
            map.forEach((value,key)=>{
              console.log("key "+key+"  value "+value);
              data[key]=value;
            });
            console.log("map data  "+JSON.stringify(data));
            this.gaindeService.removeRowDataTable(data,this.currentTableKeys[0],this.currentTableKeys[1],tableName);
            break;
          }
          case ActionDialog.ACTION_DELETE_ALL_RAWS:
          { let map=result['data'] as Map<string,string>;
             let tableName=map.get('gainDeTableName');
            this.gaindeService.removeAllRowDataTable(this.currentTableKeys[0],this.currentTableKeys[1],tableName);
            break;
          }
          default:
            break;
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
  private openDialogSelectColumn(): void {
    //let columnSource=[...this.colonneDataSource.data];
    let columnSource=[];
    this.dispColumnsHeadTableData.forEach((column)=>{
      columnSource.push({'name':column['name'],'check':!this.setColumnInvisible.has(column['name'])});
    });
    
    let dialogRef = this.dialog.open(DialogSelectColumnComponent, {
      width: '500px',
      data: {source:columnSource}
    });
  
    dialogRef.afterClosed().subscribe(result => {     
      if(result!=null && result.length>1){
        this.setColumnInvisible.clear();
        result.forEach((column)=>{
          if(!column['check']){
            this.setColumnInvisible.add(column['name']);
          }
        });
      }
      dialogRef=null;
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
@Component({
  selector: 'app-dialog-select-column',
  templateUrl: './dialog-select-column.component.html' ,
  styleUrls: ['./view-keyspace.component.scss']
})
export class DialogSelectColumnComponent implements OnInit {
checked:boolean=true;
  constructor( public dialogRef: MatDialogRef<ViewKeyspaceComponent>,@Inject(MAT_DIALOG_DATA) public data: DialogData,private gaindeService:GaindeService) { }

  ngOnInit() {
  }
  onToggleCheck(){
    this.data['source'].forEach((column)=>{
      column['check']=!this.checked;
    });
  }
  drop(event: CdkDragDrop<string[]>) {
    moveItemInArray( this.data['source'], event.previousIndex, event.currentIndex);
   // console.log("after moved "+JSON.stringify(this.data['source']));    
    this.gaindeService.emitNotifParentDialogKeyspace(this.data['source']);   
  }
  
}

