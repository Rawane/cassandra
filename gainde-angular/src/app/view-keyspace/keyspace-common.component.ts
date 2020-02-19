import { OnInit,OnDestroy,ViewChild } from '@angular/core';
import {FormGroup,FormBuilder} from '@angular/forms'; 
import {Router} from '@angular/router';
import {Subscription,Subject} from 'rxjs';
import {NestedTreeControl} from '@angular/cdk/tree';
import {MatTreeNestedDataSource} from '@angular/material/tree';
import {MatTableDataSource} from '@angular/material/table';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {MatDialog} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import {GaindeService} from '../services/gainde.service';
import {ConnectionDTO,VIEW_ECRAN,Meta,HistoryDTO} from '../model/model-dto';


export class KeyspaceComponent implements OnInit,OnDestroy {
    dataSource = new MatTreeNestedDataSource<Meta>();
    partVisible:VIEW_ECRAN; 
    allNotificationSubscription:Subscription;
    notifKeyspaceByDialog:Subscription;
    @ViewChild(MatPaginator, {static: false}) paginator: MatPaginator;
    @ViewChild(MatSort, {static: false}) sort: MatSort;
    currentConnection:ConnectionDTO;   
    notificationDialogSubject=new Subject<any>();
    homeKeyspaceVisible:boolean=false;
    treeControl = new NestedTreeControl<Meta>(node => node.metas);
    currentNodeId:string='';
    currentTableKeys:string[];
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
    tableResultQueryDataSource=new MatTableDataSource<JSON>();
    displayedColumnsQueryData: string[];
    filterResultQueryData='';
    filterTableData='';
    filterTableKeyspaceData='';
    bigTable:boolean=false;
    selectedPageIndex=0;
    selectedKeysPageIndex=0; 
    currentKeyspaceName:string;
    columnsSize:number;
    keyspaceForm:FormGroup; 
    paginationTableDataSize;
    paginationResultQuerySize;
    paginationHistoryQuerySize;
    filterHistoryData='';
    zoomData=false;
    setColumnInvisible=new Set<string>();
    historyDataSource=new MatTableDataSource<JSON>();
    displayedColumnsHistory=['query','date','count','action'];

  previousIndex: number;
  queryContent:string='';
    constructor(protected gaindeService:GaindeService,protected router:Router,protected formBuilder:FormBuilder,
        protected snackBar:MatSnackBar,protected dialog: MatDialog) {
           
         }
         ngOnInit() {
           
          }  
          ngOnDestroy() {
            this.allNotificationSubscription.unsubscribe();
          }
            
 
          protected doAfterRemoveKeyspace(mapTransfert: Map<string, any>) {
            this.gaindeService.currentGainde.content = mapTransfert.get('content');
            this.dataSource.data = this.gaindeService.currentGainde.content;
            this.openSnackBar('Le keyspace  a été  supprimée', '');
          }
        
          protected doAfterRemoveAllRows(mapTransfert: Map<string, any>) {
            this.openSnackBar('Toutes les lignes ont été supprimées', '');
            let connectionName = this.gaindeService.currentGainde.connectionName;
            let keyspaceName = this.gaindeService.currentGainde.keyspaceName;
            this.gaindeService.getAllDataTable(connectionName, keyspaceName, mapTransfert.get("content"));
          }
        
          protected doAfterRemoveOneRow(mapTransfert: Map<string, any>) {
            this.openSnackBar('La ligne a été supprimée', '');
            let connectionName = this.gaindeService.currentGainde.connectionName;
            let keyspaceName = this.gaindeService.currentGainde.keyspaceName;
            this.gaindeService.getAllDataTable(connectionName, keyspaceName, mapTransfert.get("content"));
          }
        
          protected doAfterUpdateDataToTable(mapTransfert: Map<string, any>) {
            let connectionName = this.gaindeService.currentGainde.connectionName;
            let keyspaceName = this.gaindeService.currentGainde.keyspaceName;
            this.openSnackBar('Données mis à jour avec succès', '');
            //this.dialog.closeAll();
            this.emitNotificationDialogSubject({ 'errorDialog': false, 'data': mapTransfert.get("content") });
            this.gaindeService.getAllDataTable(connectionName, keyspaceName, mapTransfert.get("content"));
          }
        
          protected doAfterInsertDataToTable(mapTransfert: Map<string, any>) {
            let connectionName = this.gaindeService.currentGainde.connectionName;
            let keyspaceName = this.gaindeService.currentGainde.keyspaceName;
            this.openSnackBar('Données insérées avec succès', '');
            this.emitNotificationDialogSubject({ 'errorDialog': false, 'data': mapTransfert.get("content") });
            this.gaindeService.getAllDataTable(connectionName, keyspaceName, mapTransfert.get("content"));
          }
          protected openSnackBar(message: string, action: string) {
            this.snackBar.open(message, action, {
              duration: 2000,
              // here specify the position
              verticalPosition: 'top',
              panelClass: ['green-snackbar']
            });
        }
        protected doAfterGetInfoTable(mapTransfert: Map<string, any>) {    
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
        
          protected doAfterSaveKeyspace(mapTransfert: Map<string, any>) {
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
       protected emitNotificationDialogSubject(content:any) {
            this.notificationDialogSubject.next(content);
          }
        protected initEcranWithCurrentData():void{
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
    protected doAfterGetAllData(mapTransfert: Map<string, any>) {
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
      protected doAfterInfoKeyspace(mapTransfert: Map<string, any>):void {
        this.keyspaceInfo = mapTransfert.get('content');
        this.tableKeyspaceInfoDataSource.data = mapTransfert.get('content')['tables'];
        this.tableKeyspaceInfoDataSource.filter = '';
        this.filterTableKeyspaceData = '';
        this.partVisible = VIEW_ECRAN.KEYSPACE_INFO;
      }
      protected doAfterRemoveTable(mapTransfert: Map<string, any>):void{
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
                 
      }
      protected doAfterGetExecuteQuery(mapTransfert: Map<string, any>):void {
        this.openSnackBar('Query exécuté avec succes', '');
        this.displayedColumnsQueryData =mapTransfert.get("content")['columns'];   
        if(this.displayedColumnsQueryData.length>0){
            this.selectedKeysPageIndex=3;           
            this.tableResultQueryDataSource.data = mapTransfert.get("content")['data'];
            this.paginationResultQuerySize = mapTransfert.get("content")['data'].length;
            this.tableResultQueryDataSource.paginator = this.paginator;
            this.tableResultQueryDataSource.sort = this.sort;
            this.tableResultQueryDataSource.filter = '';
            this.filterResultQueryData = '';
            this.tableResultQueryDataSource.sortingDataAccessor = (item, property) => {
            //console.log(item)
            switch (property) {
                case 'fromDate': {
                return new Date(item['timestamp'] * 1000);
                }
                default: return item[property];
            }
            };
        }        
        this.gaindeService.saveQuery(new HistoryDTO(this.queryContent));        
    }
    protected doAfterGetAllHistory(mapTransfert: Map<string, any>):void {     
        this.historyDataSource.data = mapTransfert.get("content");
        if(this.historyDataSource.data){
            this.paginationHistoryQuerySize = this.historyDataSource.data.length;          
            this.historyDataSource.sort = this.sort;
            this.historyDataSource.filter = '';
            this.filterHistoryData = '';
            this.tableResultQueryDataSource.sortingDataAccessor = (item, property) => {
            //console.log(item)
            switch (property) {
                case 'fromDate': {
                return new Date(item['timestamp'] * 1000);
                }
                default: return item[property];
            }
            };        
        }
    }
}