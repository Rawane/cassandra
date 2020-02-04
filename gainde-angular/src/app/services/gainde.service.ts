import { Injectable } from '@angular/core';
import {HttpClient,HttpHeaders} from '@angular/common/http';
import {Subject} from 'rxjs'
import {environment} from '../../environments/environment';
import {ConnectionDTO} from '../model/connection-dto';
import {KeyspaceDTO} from '../model/keyspace-dto';
import {ActionHttp} from '../model/action-http';
@Injectable()
export class GaindeService {
  mapTransfert=new Map<string,any>();
  mapTransfertSubject=new Subject<Map<String,any>>();
  //connectionsSubject=new Subject<any>();  
  //metaConnectionSubject=new Subject<any>(); 
 // saveConnectSubject=new Subject<boolean>();
  //keyspaceMetaSubject=new Subject<any>(); 
  //keyspaceMetaDeletedSubject=new Subject<any>();   
  //deleteConnectSubject=new Subject<boolean>();
  /*errorMsgConnectionsSubject=new Subject<string>(); 
  errorConnectionCloseSubject=new Subject<string>(); 
  connectionClosedSubject=new Subject<boolean>();
  tableInfoSubject=new Subject<JSON>();
  keyspaceInfoSubject=new Subject<JSON>();
  tableRowsSubject=new Subject<JSON>();
  tableColumnsSubject=new Subject<JSON[]>();
  errorTableSubject=new Subject<string>(); 
  errorKeyspaceSubject=new Subject<string>(); 
  removeKeyspaceSubject=new Subject<string>();
  removeTableSubject=new Subject<string>();*/
  currentMetaConnection:any;
  currentConnection:ConnectionDTO;
  httpOptions = {
    headers: new HttpHeaders({
      'Accept':  'application/json'     
    })
  };
  constructor(private httpClient:HttpClient) { }
  /*emitConnectionsSubject(connections:any) {
    this.connectionsSubject.next(connections);
  }
  emitSaveConnectSubject(saveConnect:boolean) {
    this.saveConnectSubject.next(saveConnect);
  }
  emitKeyspaceMetaSubject(keyspaceMetaSubject:boolean) {
    this.keyspaceMetaSubject.next(keyspaceMetaSubject);
  }
  emitKeyspaceDeletedMetaSubject(keyspaceMetaDeletedSubject:boolean) {
    this.keyspaceMetaDeletedSubject.next(keyspaceMetaDeletedSubject);
  }
  
  emitDeleteConnectSubject(deleteed:boolean) {
    this.deleteConnectSubject.next(deleteed);
  }
  emitErrorMsgConnectionsSubject(error:string) {
    this.errorMsgConnectionsSubject.next(error);
  }
  emitErrorConnectionClosedSubject(error:string) {
    this.errorConnectionCloseSubject.next(error);
  }
  
  emitMetaConnectionSubject(metaconnections:any) {
    this.metaConnectionSubject.next(metaconnections);
  }
  emitConnectionClosedSubject(close:boolean) {
    this.connectionClosedSubject.next(close);
  }
  emitTableInfoSubject(tableInfo:JSON) {
    this.tableInfoSubject.next(tableInfo);
  }
  emitTableColumnsSubject(tableColumnsSubject:JSON[]) {
    this.tableColumnsSubject.next(tableColumnsSubject);
  }
  emitTableRowsSubject(tableRowsSubject:JSON) {
    this.tableRowsSubject.next(tableRowsSubject);
  }
  emitErrorTableSubject(error:string) {
    this.errorTableSubject.next(error);
  }
  emitErrorKeyspaceSubject(error:string) {
    this.errorKeyspaceSubject.next(error);
  }
  emitKeyspaceInfoSubject(keyspaceInfo:JSON) {
    this.keyspaceInfoSubject.next(keyspaceInfo);
  }
  emitRemoveKeyspaceSubject(result:string) {
    this.removeKeyspaceSubject.next(result);
  }
  emitRemoveTableSubject(result:string) {
    this.removeTableSubject.next(result);
  }*/
  emitMapTransfertSubject(action:ActionHttp,content:any) {
    this.mapTransfert.set("content",content);
    this.mapTransfert.set("type",action);
    this.mapTransfertSubject.next(this.mapTransfert);
  }
  getAllConnections() {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/all',this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));
          // this.emitConnectionsSubject(response);          
           this.emitMapTransfertSubject(ActionHttp.ALL_CONNECTION,response);
        },
        (error) => {
          console.log('Erreur ! : ' + error);         
           this.emitMapTransfertSubject(ActionHttp.ALL_CONNECTION_ERROR,error['error']['error']);
        }
      );
      
  }  
  saveConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
      // this.emitSaveConnectSubject(true);      
       this.emitMapTransfertSubject(ActionHttp.SAVE_CONNECTION,connectionDTO);
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));       
       // this.emitSaveConnectSubject(false);        
        this.emitMapTransfertSubject(ActionHttp.SAVE_CONNECTION_ERROR,error['error']['error']);
      }
    );    
  }
  updateConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
      // this.emitSaveConnectSubject(true);      
       this.emitMapTransfertSubject(ActionHttp.UPDATE_CONNECTION,connectionDTO);  
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));        
       // this.emitSaveConnectSubject(false);
        this.emitMapTransfertSubject(ActionHttp.UPDATE_CONNECTION,error['error']['error']);
      }
    );    
  }
  deleteConnection(name:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/connection/'+name,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
       //this.emitDeleteConnectSubject(true);
       this.emitMapTransfertSubject(ActionHttp.DELETE_CONNECTION,name);  
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));      
        //this.emitDeleteConnectSubject(false);       
        this.emitMapTransfertSubject(ActionHttp.DELETE_CONNECTION_ERROR,error['error']['error']);  
      }
    );    
  }
  connecToCassandra(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection/connecto',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
      // console.log('response  : ' + JSON.stringify(response));      
       this.refreshAllMeta(connectionDTO.name,ActionHttp.CONNECT_TO);
      },
      (error) => {     
        console.log('Erreur ! : ' + JSON.stringify(error['error']['error']));   
        //this.emitErrorMsgConnectionsSubject(error['error']['error']) ;
        this.emitMapTransfertSubject(ActionHttp.CONNECT_TO_ERROR,error['error']['error']);        
      }
    );    
  }
  getAllMeta(name:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/metadata/all/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
        // console.log('response  : ' + JSON.stringify(response));   
         //this.emitMetaConnectionSubject(response); 
         this.emitMapTransfertSubject(ActionHttp.ALL_META,response);       
        },
        (error) => {
          console.log('Erreur ! : ' + error);
         // this.emitErrorMsgConnectionsSubject(error['error']['error']) ;         
          this.emitMapTransfertSubject(ActionHttp.ALL_META_ERROR,error['error']['error']);        
        }
      );      
  }  
  closeConnection(name:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/close/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
          console.log('response  : ' + JSON.stringify(response));   
         // this.emitConnectionClosedSubject(true);           
          this.emitMapTransfertSubject(ActionHttp.CLOSE_CONNECTION,response);   
        },
        (error) => {
          console.log('Erreur ! : ' + error);
         // this.emitErrorMsgConnectionsSubject(error['error']['error']) ;
          //this.emitErrorConnectionClosedSubject(error['error']['error']) ;
          this.emitMapTransfertSubject(ActionHttp.CLOSE_CONNECTION_ERROR,error['error']['error']);   
        }
      );      
  }  
  getInfoTable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/connection/metadata/table/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));   
         //this.emitTableInfoSubject(response);        
         this.emitMapTransfertSubject(ActionHttp.INFO_TABLE,response);   
        },
        (error) => {
          console.log('Erreur ! : ' + error);        
          //this.emitErrorTableSubject(error['error']['error']);         
          this.emitMapTransfertSubject(ActionHttp.INFO_TABLE_ERROR,error['error']['error']);   
        }
      );      
  }
  getAllDatatable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON[]>(environment['basePathGainde']+'/connection/data/columns/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));   
         //this.emitTableColumnsSubject(response);
        },
        (error) => {
          console.log('Erreur ! : ' + error);        
        //this.emitErrorTableSubject(error['error']['error']) ;
        }
      );      
  } 
  saveKeyspace(connectionName:string,keyspaceDTO:KeyspaceDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName,keyspaceDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));       
       this.refreshAllMeta(connectionName,ActionHttp.SAVE_KEYSPACE);
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));       
         //this.emitErrorKeyspaceSubject(error['error']['error']) ;        
         this.emitMapTransfertSubject(ActionHttp.SAVE_KEYSPACE_ERROR,error['error']['error']);  
      }
    );    
  }  
  private refreshAllMeta(name:string,action:ActionHttp) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/metadata/all/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
        // console.log('response  : ' + JSON.stringify(response)); 
         // this.emitMetaConnectionSubject(response);  
          this.emitMapTransfertSubject(action,response); 
        },
        (error) => {
          console.log('Erreur ! : ' + error);              
          this.emitMapTransfertSubject(action,error['error']['error']);  
        }
      );      
  } 
  getKeyspaceInfo(connectionName:string,keyspace) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName+'/'+keyspace,this.httpOptions)
      .subscribe(
        (response) => {               
          // console.log('response  : ' + JSON.stringify(response));   
          //this.emitKeyspaceInfoSubject(response);          
          this.emitMapTransfertSubject(ActionHttp.INFO_KEYSPACE,response);  
        },
        (error) => {
          console.log('Erreur ! : ' + error);
          this.emitMapTransfertSubject(ActionHttp.INFO_KEYSPACE_ERROR,error['error']['error']);  
        }
      );      
  }  
  removeKeySpace(connectionName:string,keyspcaeName:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName+'/'+keyspcaeName,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
      // this.emitRemoveKeyspaceSubject(keyspcaeName);
       this.refreshAllMeta(connectionName,ActionHttp.REMOVE_KEYSPACE);
       
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));      
       // this.emitDeleteConnectSubject(false);
        this.emitMapTransfertSubject(ActionHttp.REMOVE_KEYSPACE_ERROR,error['error']['error']);  
      }
    );    
  }
  removeTable(connectionName:string,keyspcaeName:string,tableName:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/table/'+connectionName+'/'+keyspcaeName+'/'+tableName,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
             
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));      
         //this.emitDeleteConnectSubject(false);       
         this.emitMapTransfertSubject(ActionHttp.REMOVE_TABLE_ERROR,error['error']['error']);  
      }
    );    
  }
  
}
