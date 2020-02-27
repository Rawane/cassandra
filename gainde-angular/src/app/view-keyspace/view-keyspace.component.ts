import { Component, OnInit,Inject, OnDestroy } from '@angular/core';
import {FormGroup,FormBuilder,Validators} from '@angular/forms'; 
import { DatePipe } from '@angular/common';
import {Router} from '@angular/router';
import {Subscription} from 'rxjs';
import { tap} from 'rxjs/operators';
import {MatDialog, MatDialogRef,MAT_DIALOG_DATA} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import beautify from 'xml-beautifier';
import {GaindeService} from '../services/gainde.service';
import {KeyspaceDTO,ActionHttp,VIEW_ECRAN,ActionDialog,Meta} from '../model/model-dto';
import {KeyspaceComponent} from './keyspace-common.component';
import{DialogData} from '../view-connections/view-connections.component';
import {CdkDragStart, CdkDropList,CdkDragDrop, moveItemInArray} from '@angular/cdk/drag-drop';
import { GaindeDataSource } from '../commons/server-side-datasource';
@Component({
  selector: 'app-view-keyspace',
  templateUrl: './view-keyspace.component.html',
  styleUrls: ['./view-keyspace.component.scss']
})
export class ViewKeyspaceComponent extends KeyspaceComponent {  
  
  
  
  hasChild = (_: number, node: Meta) => !!node.metas && node.metas.length > 0;
  constructor(protected gaindeService:GaindeService,protected router:Router,protected formBuilder:FormBuilder,
    protected snackBar:MatSnackBar,protected dialog: MatDialog) {
      super(gaindeService,router,formBuilder,snackBar,dialog);
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
    setDisplayedColumnsBigData() {      
      this.tableDataPaginateDataSource.columnsDisplayed=[];
      this.tableDataPaginateDataSource.columns.forEach(( colunm, index) => {
       // colunm[index] = index;
        this.tableDataPaginateDataSource.columnsDisplayed[index] = colunm['name'];
      });
      this.tableDataPaginateDataSource.columnsDisplayed.push('action_gainde');
      this.tableDataPaginateDataSource.columnsDisplayed.push('action_remove_gainde');
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
  setDisplayedColumnsBigDataByNotif(columns:any) {      
      let arrayTemp=[...this.tableDataPaginateDataSource.columns];
      this.tableDataPaginateDataSource.columnsDisplayed=[];
      this.tableDataPaginateDataSource.columns=[];
      columns.forEach(( colunm, index) => {        
        this.tableDataPaginateDataSource.columnsDisplayed[index] = colunm.name;
        let indexCol:number;
        for(let i=0;i<arrayTemp.length;i++){
         if(arrayTemp[i]['name']==colunm.name){
          indexCol=i;
          break;
         }
        }
        this.tableDataPaginateDataSource.columns[index]=arrayTemp[indexCol];
      });
      this.tableDataPaginateDataSource.columnsDisplayed.push('action_gainde');
      this.tableDataPaginateDataSource.columnsDisplayed.push('action_remove_gainde');
    }
    dragStarted(event: CdkDragStart, index: number ) {
      this.previousIndex = index;
      //console.log('dragStarted prev '+this.previousIndex);
    }
  
    dropListDropped(event: CdkDropList, index: number) {
      if (event) {
        //console.log('dropListDropped prev '+this.previousIndex+'   new '+index);
        moveItemInArray(this.dispColumnsHeadTableData, this.previousIndex, index);
        //console.log('dropListDropped '+JSON.stringify(this.dispColumnsHeadTableData));
        this.setDisplayedColumns();
      }
    }
    dragStartedBigData(event: CdkDragStart, index: number ) {
      this.previousIndex = index;
      //console.log('dragStarted prev '+this.previousIndex);
    }
  
    dropListDroppedBigData(event: CdkDropList, index: number) {
      if (event) {
        //console.log('dropListDropped prev '+this.previousIndex+'   new '+index);
        moveItemInArray(this.tableDataPaginateDataSource.columns, this.previousIndex, index);
        //console.log('dropListDropped '+JSON.stringify(this.dispColumnsHeadTableData));
        this.setDisplayedColumnsBigData();
      }
    }
onExecuteQuery(){
    //console.log("onExecuteQuery "+this.queryContent);
    this.tableResultQueryDataSource.data=[];
    let connectionName=this.gaindeService.currentGainde.connectionName;
    let keyspaceName=this.gaindeService.currentGainde.keyspaceName;  
    this.gaindeService.executeQuery(connectionName,keyspaceName,this.queryContent);
    this.isQueryLoading=true;
}

  ngOnInit() {
    this.currentConnection=this.gaindeService.currentGainde.connection;
    this.initEcranWithCurrentData();
    /*this.notifKeyspaceByDialog=this.gaindeService.notifParentDialogKeyspace.subscribe((dataSource:any)=>{
    this.setDisplayedColumnsByNotif(dataSource);
    });*/
    this.initObservable();    
    this.tableDataPaginateDataSource=new GaindeDataSource(this.gaindeService); 
  }  
  ngAfterViewInit() {
   
}

loadDataRows() {
  this.tableDataPaginateDataSource.loadDataRows(
    this.currentTableKeys[2],
      '',
      'asc',this.tableDataPaginateDataSource.currentPagination.total,this.tableDataPaginateDataSource.currentPagination.pageSate,this.tableDataPaginateDataSource.currentPagination.pageNumSate,
      this.paginatorGainde.pageSize,
      this.paginatorGainde.pageIndex+1);
}
  private initObservable() {
    this.notificationSelectKeyIndexSubs=this.notificationSelectKeyIndex.subscribe((pageIndex)=>{
      /*setTimeout(()=>{    
        this.selectedKeysPageIndex = pageIndex;
      }, 1000);*/
     this.selectedKeysPageIndex=pageIndex;
    });
    this.allNotificationSubscription = this.gaindeService.mapTransfertViewKeyspaceSubject.subscribe((mapTransfert: Map<string, any>) => {
      let mapToString = '';
      mapTransfert.forEach((key, item) => {
        mapToString = mapToString + ' ' + item + '  value=' + JSON.stringify(mapTransfert.get(item));
      });
      console.log('ViewKeyspaceComponent mapTransfert ' + mapTransfert.get("type"));
      switch (mapTransfert.get("type") as ActionHttp) {
        case ActionHttp.CLOSE_CONNECTION:
          {
            this.router.navigate(['/viewConnections']);
            break;
          }
        case ActionHttp.CLOSE_CONNECTION_ERROR:
          {
            this.openDialog('Connection', "Erreur lors de la fermiture de la connection", false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.REMOVE_KEYSPACE:
          {
            this.doAfterRemoveKeyspace(mapTransfert);
            break;
          }
        case ActionHttp.REMOVE_KEYSPACE_ERROR:
          {
            this.openDialog('Suppression Keyspace', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.REMOVE_TABLE:
          {
            this.doAfterRemoveTable(mapTransfert);
            break;
          }
        case ActionHttp.REMOVE_TABLE_ERROR:
          {
            this.openDialog('Suppression Table', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.INFO_TABLE:
          {
            this.doAfterGetInfoTable(mapTransfert);
            break;
          }
        case ActionHttp.INFO_TABLE_ERROR:
          {
            this.openDialog('Erreur de Connection', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.SAVE_KEYSPACE:
          {
            this.doAfterSaveKeyspace(mapTransfert);
            break;
          }
        case ActionHttp.SAVE_KEYSPACE_ERROR:
          {
            this.openDialog('Keyspace', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.INFO_KEYSPACE:
          {
            this.doAfterInfoKeyspace(mapTransfert);
            //console.log('INFO_KEYSPACE  : ' + JSON.stringify(this.keyspaceInfo));
            break;
          }
        case ActionHttp.INFO_KEYSPACE_ERROR:
          {
            this.openDialog('INFO Keyspace', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.ALL_DATA_TABLE:
          { 
            this.doAfterGetAllData(mapTransfert);
            break;
          }
        case ActionHttp.ALL_DATA_TABLE_ERROR:
          { this.isDataLoading=false;
            this.openDialog('Table ', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.INSERT_DATA_TABLE:
          {
            this.doAfterInsertDataToTable(mapTransfert);
            break;
          }
        case ActionHttp.INSERT_DATA_TABLE_ERROR:
          {
            this.emitNotificationDialogSubject({'type':1, 'errorDialog': true, 'data': mapTransfert.get("content") });
            break;
          }
          case ActionHttp.INSERT_BIG_DATA_TABLE:
            {
              this.doAfterInsertBigDataToTable(mapTransfert);
              break;
            }
        case ActionHttp.UPDATE_DATA_TABLE:
          {
            this.doAfterUpdateDataToTable(mapTransfert);
            break;
          }
          case ActionHttp.UPDATE_BIG_DATA_TABLE:
          {
            this.doAfterUpdateBigDataToTable(mapTransfert);
            break;
          }
        case ActionHttp.UPDATE_DATA_TABLE_ERROR:
          {
            this.emitNotificationDialogSubject({'type':1, 'errorDialog': true, 'data': mapTransfert.get("content") });
            break;
          }
        case ActionHttp.REMOVE_ONE_ROW:
          {
            this.doAfterRemoveOneRow(mapTransfert);
            break;
          }
          case ActionHttp.REMOVE_ONE_ROW_BIG_DATA:
          {
            this.doAfterRemoveOneRowBigData(mapTransfert);
            break;
          }
        case ActionHttp.REMOVE_ONE_ROW_ERROR:
          {
            this.openDialog('Supression données ', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.REMOVE_ALL_ROWS:
          {
            this.doAfterRemoveAllRows(mapTransfert);
            break;
          }
          case ActionHttp.REMOVE_ALL_ROWS_BIG_DATA:
            {
              this.doAfterRemoveAllRowsBigData(mapTransfert);
              break;
            }
        case ActionHttp.REMOVE_ALL_ROWS_ERROR:
          {
            this.openDialog('Supression données ', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
        case ActionHttp.EXECUTE_QUERY:
          { 
            this.doAfterGetExecuteQuery(mapTransfert);
            break;
          }
        case ActionHttp.EXECUTE_QUERY_ERROR:
          { this.isQueryLoading=false;
            this.openDialog('Execute Query ', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
          case ActionHttp.SAVE_QUERY_HISTORY:
          {
           //NOP
            break;
          }
        case ActionHttp.SAVE_QUERY_HISTORY_ERROR:
          {
            this.openDialog('History', mapTransfert.get("content"), false, '', ActionDialog.INFO);
            break;
          }
          case ActionHttp.ALL_HISTORY:
            {
              this.doAfterGetAllHistory(mapTransfert);
              break;
            }
          case ActionHttp.ALL_HISTORY_ERROR:
            {
              this.openDialog('History', mapTransfert.get("content"), false, '', ActionDialog.INFO);
              break;
            }
            case ActionHttp.DELETE_HISTORY:
            { this.openSnackBar('La ligne a étée supprimée', '');
              this.gaindeService.getAllHistories(this.allHistory,this.gaindeService.currentGainde.connectionName);
              break;
            }
          case ActionHttp.DELETE_HISTORY_ERROR:
            {
              this.openDialog('History', mapTransfert.get("content"), false, '', ActionDialog.INFO);
              break;
            }
        default:
          break;
      }
    });
    
  }

  onVerifyDisplay(columnName:string):boolean{   
    //console.log(columnName)
    return  this.setColumnInvisible.has(columnName);
  }
  onVerifyDisplayBigData(columnName:string):boolean{   
    //console.log(columnName)
    return  this.setColumnBigDataInvisible.has(columnName);
  }
  
  onShowSelectColumn(){
    this.openDialogSelectColumn(this.dispColumnsHeadTableData,false);
  }
  onShowSelectColumnBigData(){
    this.openDialogSelectColumn(this.tableDataPaginateDataSource.columns,true);
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
  onApplyFilterHistory(filterVal: string){
    this.historyDataSource.filter = filterVal.trim().toLowerCase();       
  }
  onApplyFilterResultQuery(filterVal: string){
    this.tableResultQueryDataSource.filter = filterVal.trim().toLowerCase();       
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
        this.whereColumnName='';
        this.whereColumnValue='';
        if(this.currentTableKeys){
          this.isDataLoading=true;
          this.gaindeService.getAllDataTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
        }  
      }else{
        if(this.selectedPageIndex==2) {
          this.tableDataPaginateDataSource.whereColumnName='';
          this.tableDataPaginateDataSource.whereColumnValue='';
          this.tableDataPaginateDataSource.isQuery=false;
          this.tableDataPaginateDataSource.loadDataRows(this.currentTableKeys[2], '','asc',-1,'',1,  this.paginator.pageSize,  1);         
         
        } 
      }
    }
  }
  onClickNavigateTab(){
    //console.log('onClickNavigateTab  : ' + this.selectedPageIndex);
    if(this.selectedPageIndex==1){
      this.whereColumnName='';
      this.whereColumnValue='';
      if(this.currentTableKeys && this.tableDatasDataSource.data.length==0){
        this.isDataLoading=true;
        this.gaindeService.getAllDataTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      }  
    }else{
      if(this.selectedPageIndex==2) 
      {
        this.tableDataPaginateDataSource.whereColumnName='';
        this.tableDataPaginateDataSource.whereColumnValue='';
        if(this.currentTableKeys){
          //this.isDataLoading=true;   
          this.paginatorGainde.page.pipe(
            tap(() => this.loadDataRows())
        )
        .subscribe();      
          this.tableDataPaginateDataSource.loadDataRows(this.currentTableKeys[2], '','asc',-1,'',1,  this.paginatorGainde.pageSize,  1);         
         
         
        }  
      }

    }
    
  }

  onClickEditRow(row,name){
    let data:any={'columns':this.dispColumnsHeadTableData,
    'tableName':name,'row':row,'added':false,'bigData':false};
   // console.log('onClickEditRow  : ' + JSON.stringify(data)); 
    this.openDialogRow(data);
    
  }
  onClickEditRowBigData(row,name){
    let data:any={'columns':this.tableDataPaginateDataSource.columns,
    'tableName':name,'row':row,'added':false,'bigData':true};
   // console.log('onClickEditRow  : ' + JSON.stringify(data)); 
    this.openDialogRow(data);
    
  }
  onClickAddNewRow(name){
    //console.log('onClickEditRow  : ' + name); 
    let row:any={};
    this.dispColumnsHeadTableData.forEach(eltD=>{
      row[eltD.name]="";
    });
    let data:any={"columns":this.dispColumnsHeadTableData,
    "tableName":name,'row':row,"added":true,'bigData':false}; 
    this.openDialogRow(data);
  }
  onClickAddNewRowBigData(name){
    //console.log('onClickEditRow  : ' + name); 
    let row:any={};
    this.tableDataPaginateDataSource.columns.forEach(eltD=>{
      row[eltD['name']]="";
    });
    let data:any={"columns":this.tableDataPaginateDataSource.columns,
    "tableName":name,'row':row,"added":true,'bigData':true}; 
    this.openDialogRow(data);
  }
  onClickRemoveAllRow(tableName:string){
    let map=new Map<string,string>();
    map.set('gainDeTableName',tableName);
    map.set('bigDataGainde','false');
    this.openDialog('Confirmation de suppression',"Voulez-vous supprimer toutes lignes de la table  "+tableName+" du Keyspace "+this.currentTableKeys[1]+" ?",true,map,ActionDialog.ACTION_DELETE_ALL_RAWS); 
 }
 onClickRemoveAllRowBigData(tableName:string){
  let map=new Map<string,string>();
  map.set('gainDeTableName',tableName);
  map.set('bigDataGainde','true');
  this.openDialog('Confirmation de suppression',"Voulez-vous supprimer toutes lignes de la table  "+tableName+" du Keyspace "+this.currentTableKeys[1]+" ?",true,map,ActionDialog.ACTION_DELETE_ALL_RAWS); 
}
  onClickRemoveRow(row:any,tableName:string){
    let map=new Map<string,string>();
    map.set('gainDeTableName',tableName);
    map.set('bigDataGainde','false');
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
  onClickRemoveRowBigData(row:any,tableName:string){
    let map=new Map<string,string>();
    map.set('gainDeTableName',tableName);
    map.set('bigDataGainde','true');
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
  onClickShowQuery(tableName:string){  
      this.partVisible=VIEW_ECRAN.KEYSPACE_INFO;  
      this.queryContent='SELECT * from "'+this.gaindeService.currentGainde.keyspaceName+'"."'+tableName+'";';  
      this.gaindeService.getKeyspaceInfo(this.gaindeService.currentGainde.connectionName,this.gaindeService.currentGainde.keyspaceName);     
      this.selectedKeysPageIndex=2;
  }
  onClickQueryWhere(tableName:string){
    let keyspaceName=this.gaindeService.currentGainde.keyspaceName;
    let query='SELECT * from "'+keyspaceName+'"."'+tableName+'" WHERE "'+this.whereColumnName+'"=\''+this.whereColumnValue+'\'';
    this.displayedColumnsTableData=[];
    this.dispColumnsHeadTableData=[];
    this.gaindeService.executeTableWhereQuery(this.gaindeService.currentGainde.connectionName,keyspaceName,query);
  }
  onClickQueryWhereBigData(tableName:string){ 
    this.tableDataPaginateDataSource.isQuery=true;
    this.tableDataPaginateDataSource.mapWhereClause=new Map<string,string>();
    this.tableDataPaginateDataSource.mapWhereClause.set(this.tableDataPaginateDataSource.whereColumnName,this.tableDataPaginateDataSource.whereColumnValue);
    this.tableDataPaginateDataSource.loadDataRows(tableName, '','asc',-1,'',1,  this.paginator.pageSize,  1);  
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
    //console.log('onClickAddNewTable connectionName='+connectionName+' keyspace '+keyspaceName);
    this.gaindeService.currentGainde.connectionName=connectionName;
    this.gaindeService.currentGainde.keyspaceName=keyspaceName;  
    this.gaindeService.currentGainde.tableName=null;   
    this.openDialogTableInfo(5);    
  }
  onClickEditTable(connectionName:string,keyspaceName:string,tableName:string){
   // console.log('onClickEditTable connectionName='+connectionName+' keyspace '+keyspaceName+' table name '+tableName);   
    this.gaindeService.currentGainde.connectionName=connectionName;
    this.gaindeService.currentGainde.keyspaceName=keyspaceName;  
    this.gaindeService.currentGainde.tableName=tableName; 
    this.router.navigate(['/editTable']);
  }
  onClickEditCurrentTable(){    
    //console.log('onClickEditTableView ='+JSON.stringify(this.currentTableKeys));   
    this.gaindeService.currentGainde.connectionName=this.currentTableKeys[0];
    this.gaindeService.currentGainde.keyspaceName=this.currentTableKeys[1];  
    this.gaindeService.currentGainde.tableName=this.currentTableKeys[2]; 
    this.router.navigate(['/editTable']);
  }
  onClickNavigateKeyspace(){
   if(this.selectedKeysPageIndex==4){
     this.gaindeService.getAllHistories(this.allHistory,this.gaindeService.currentGainde.connectionName);
   }
  }
  onClickDumpKeyspace(connectionName:string,keyspaceName:string){
    this.gaindeService.dumpKeyspace(true,connectionName,keyspaceName);
  }
  onClickFilterHistoryByConnection(){
   // console.log('onClickFilterHistoryByConnection ='+this.allHistory);   
    this.gaindeService.getAllHistories(!this.allHistory,this.gaindeService.currentGainde.connectionName);
  }
  onRefreshData(tableName:string){
    let connectionName=this.gaindeService.currentGainde.connectionName;
    let keyspaceName=this.gaindeService.currentGainde.keyspaceName; 
    this.isDataLoading=true;   

    this.gaindeService.getAllDataTable(connectionName,keyspaceName,tableName);
  }
  onRefreshBigData(tableName:string){     
    this.tableDataPaginateDataSource.isQuery=false;    
    this.tableDataPaginateDataSource.loadDataRows(tableName, '','asc',-1,'',1,  this.paginator.pageSize,  1);         
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
  onClickEditQuery(query){
    this.queryContent=query;
    this.selectedKeysPageIndex=2;
  }
  onClickImportDump(connectionName){
    this.openDialogImportKeyspace(connectionName);
  }
  onClickViewCell(name:string,data:string){
    let rows:number=1;
    if(data){
      rows=1+ Math.trunc(data.length/68);
    }    
    
    this.openDialogViewCell(name,data,rows,true);
  }
  onClickViewEditCell(name:string,data:string,readOnly:boolean){
    let rows:number=1;
    if(data){
      rows=1+ Math.trunc(data.length/68);
    }    
    
    this.openDialogViewCell(name,data,rows,readOnly);
  }
  onClickRemoveHistoryQuery(id:string){
    this.gaindeService.deleteHistory(id);
  }
  onZoomTable(){ 
    this.zoomData=!this.zoomData;
    //console.log('onZoomTable  : ' + this.zoomData);
  }
   openDialog(pTitle:string,pText:string, cancelButton:boolean,map:any,action:ActionDialog): void {
    let dialogRef = this.dialog.open(DialogInfoKeyspaceComponent, {
      width: '500px',
      data: {text: pText,title:pTitle,btnCancel:cancelButton,data:map,action:action}
    });
  
    dialogRef.afterClosed().subscribe(result => { 
      //console.log('1 afterClosed '+JSON.stringify(result));
      if(result!=null){
       // console.log('1 afterClosed '+JSON.stringify(result));
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
            let bigData=map.get('bigDataGainde')=='true';
            map.delete('gainDeTableName');
            map.delete('bigDataGainde');
            let data={};
            map.forEach((value,key)=>{
              //console.log("key "+key+"  value "+value);
              data[key]=value;
            });
            //console.log("map data  "+JSON.stringify(data));
            this.gaindeService.removeRowDataTable(data,this.currentTableKeys[0],this.currentTableKeys[1],tableName,bigData);
            break;
          }
          case ActionDialog.ACTION_DELETE_ALL_RAWS:
          { let map=result['data'] as Map<string,string>;
             let tableName=map.get('gainDeTableName');
             let bigData=map.get('bigDataGainde')=='true';
            this.gaindeService.removeAllRowDataTable(this.currentTableKeys[0],this.currentTableKeys[1],tableName,bigData);
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
       //console.log("openDialogTableInfo "+result);
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
      disableClose:true,
      panelClass: 'customDialogEdit'
    });  
    dialogRefRow.componentInstance.setGaindeService(this.gaindeService);  
    dialogRefRow.componentInstance.setComponent(this);
    dialogRefRow.afterClosed().subscribe(result => {    
      
      dialogRefRow=null;

    });
  }
  private openDialogSelectColumn(columns:any,bigData:boolean): void {
    //let columnSource=[...this.colonneDataSource.data];
    let columnSource=[];
   if(columns){
    columns.forEach((column)=>{
      if(bigData){       
      columnSource.push({'name':column['name'],'check':!this.setColumnBigDataInvisible.has(column['name'])}); 
      }else{       
        columnSource.push({'name':column['name'],'check':!this.setColumnInvisible.has(column['name'])});  
      }
    });
  }
    let dataSelect={'columns':columnSource,'bigData':bigData};
    let dialogRef = this.dialog.open(DialogSelectColumnComponent, {
      width: '500px',
      data: {source:dataSelect}
    });
  
    dialogRef.afterClosed().subscribe(result => {  
      console.log('afterClosed '+JSON.stringify(result));   
      if(result!=null){
        if(result['bigData']){
          console.log('afterClosed setColumnBigDataInvisible');
          this.setDisplayedColumnsBigDataByNotif(result['columns']);
          this.setColumnBigDataInvisible.clear();
          result['columns'].forEach((column)=>{
            if(!column['check']){
              this.setColumnBigDataInvisible.add(column['name']);
            }
          });
        }else{
          console.log('afterClosed setColumnBigDataInvisible');
          this.setDisplayedColumnsByNotif(result['columns']);
          this.setColumnInvisible.clear();
          result['columns'].forEach((column)=>{
              if(!column['check']){
                this.setColumnInvisible.add(column['name']);
              }
            });
        }
        
      }
      dialogRef=null;
    });
    
  }
  
  public openDialogViewCell(name:string,dataCell:any,rows:number,readOnly:boolean): void {
    let dialogRefTableInfo = this.dialog.open(DialogViewCellComponent, {
      width: '700px', 
      minHeight:'100px', 
      height : 'auto',   
      data: {name:name,text: dataCell,rows:rows,readOnly:readOnly}
    });
  
    dialogRefTableInfo.afterClosed().subscribe(result => { 
      
      if(result!=null){
        this.emitNotificationDialogSubject({'type':2, 'errorDialog': true, 'data': result});
      }

    });
  }
  private openDialogImportKeyspace(text:string): void {
    let dialogRefTableInfo = this.dialog.open(DialogImportKeyspaceComponent, {
      width: '400px', 
      minHeight:'120px', 
      height : 'auto', 
      disableClose:true,
      position: {
        top: '50px',
        left: '250px'
      } , 
      data: {text:text}
    });
  
    dialogRefTableInfo.afterClosed().subscribe(result => { 
      
      if(result!=null){
        
      }

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
export class DialogEditRowComponent implements OnInit,OnDestroy {
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
      //console.log("notificationSubscription "+JSON.stringify(content));
      if(content['type']==1)
      {
          if(content['errorDialog']){
            this.messageError="Une erreur non spécifié s'est produite";
            if(content['data'] && content['data']){
              this.messageError=content['data'] ; 
            }  
            this.error=true;  
          }else{
              this.dialogRef.close();
          }
      }else{
        if(content['type']==2)
          {
            if(content['data'] && content['data']){
              let name=content['data']['name'];
              let text=content['data']['text'];
              this.data['row'][name]=text;              
            }
          }          
      }
    });
  
  }
  ngOnDestroy(){
    if(this.notificationSubscription){
      this.notificationSubscription.unsubscribe();
    }
  }
  onShowViewCell(type:string){
    if(type=='TEXT' || type=='BLOB'){
      return true;
    }
    return false;
  }
  onClickViewCell(primaryKey:boolean,type:string,name:string,data:string){
    if(!primaryKey && (type=='TEXT' || type=='BLOB')){
     this.viewParent.onClickViewEditCell(name,data,false);
    }
  
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
         this.gaindeService.insertDataTable(requestData,connectionName,keyspaceName,data['tableName'],data['bigData']);
      }else{
        let partitionKeys:string[]=[];
        let requestData:any={};
        requestData['data']={};
        let mapTemp=new Map<string,string>();
        data['columns'].forEach(col=>{
           if(col['partitionKey'] || col['clusteredColumn']){
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
       this.gaindeService.updateDataTable(requestData,connectionName,keyspaceName,data['tableName'],data['bigData']);
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
  onValueChange(name:string){    
    this.setColumns.add(name);    
  }
  onValueChangeDate(name:string){    
    this.setColumns.add(name);
    //console.log("onValueChange "+name+" value "+value);
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
    this.data['source']['columns'].forEach((column)=>{
      column['check']=!this.checked;
    });
  }
  drop(event: CdkDragDrop<string[]>) {
    //console.log("event "+event+'   '+JSON.stringify(this.data['source']));       
    moveItemInArray(this.data['source']['columns'], event.previousIndex, event.currentIndex);
    //console.log("after moved "+JSON.stringify(this.data['source']['columns']));    
    //this.gaindeService.emitNotifParentDialogKeyspace(this.data['source']['columns']);   
  }
  
}


@Component({
  selector: 'app-dialog-view-cell',
  templateUrl: './dialog-view-cell.component.html' ,
  styleUrls: ['./view-keyspace.component.scss']
})
export class DialogViewCellComponent implements OnInit {

  constructor( public dialogRef: MatDialogRef<ViewKeyspaceComponent>,@Inject(MAT_DIALOG_DATA) public data: DialogData) { }

  ngOnInit() {
  }
  onClickEncode(){
    if(this.data.text){
        try {
            this.data.text=btoa(this.data.text);      
          if(this.data.text){
            this.data.rows=Math.trunc(1+ this.data.text.length/68);
          } 
        }
        catch(error) {
            //console.error(error);      
        }
    }
  }
  onClickDecode(){
    if(this.data.text){
      let splitDecode=this.data.text.split('\\n');
      let dataToDecode:string=splitDecode.join('');   
    try {      
      this.data.text=atob(dataToDecode);
      if(this.data.text){
        this.data.rows=1+ Math.max(splitDecode.length,Math.trunc(this.data.text.length/68));
      } 
    }
    catch(error) {
      //console.error(error);      
    }
    
    }
  }
  onClickFormat(){
  try {
    this.data.text=JSON.stringify(JSON.parse(this.data.text), null, 2) ;
    let rows=Math.trunc(this.data.text.split('"').length/2);
    if(rows<10){
      this.data.rows=rows+2;
    }else{
      if(rows<20){
        this.data.rows=rows+5;
      } else{
        if(rows<30){
          this.data.rows=rows+7;
        } else{
          this.data.rows=rows+10;
        }
      }
    }
    console.log('onClickFormat rows'+this.data.rows);
  } catch (error) {
    this.data.text=beautify(this.data.text);    
    let sizeText=this.data.text.split('\n').length;
    this.data.rows=sizeText+3;
    console.log('format XML sizeText'+sizeText);
  }
}
}


@Component({
  selector: 'app-dialog-import-keyspcae',
  templateUrl: './dialog-import-keyspace.component.html' ,
  styleUrls: ['./view-keyspace.component.scss']
})
export class DialogImportKeyspaceComponent implements OnInit {
  formImport:FormGroup; 
  fileData: File = null;
  constructor( public dialogRef: MatDialogRef<ViewKeyspaceComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,private formBuilder:FormBuilder,private gaindeService:GaindeService) { }

  ngOnInit() {
    this.initForm();
  }
  fileProgress(fileInput: any) {
    this.fileData = <File>fileInput.target.files[0];
    
}
  
  onSubmitForm(){
    let formData = new FormData();
      formData.append('file', this.fileData);
      this.dialogRef.close();
      this.gaindeService.importKeyspace(this.data.text,formData);
    }
    private initForm(){
      this.formImport = this.formBuilder.group({    
        file: ['',Validators.required]
       
      });
      
    }
}

