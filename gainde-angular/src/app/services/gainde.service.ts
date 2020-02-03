import { Injectable } from '@angular/core';
import {HttpClient,HttpHeaders} from '@angular/common/http';
import {Subject} from 'rxjs'
import {environment} from '../../environments/environment';
import {ConnectionDTO} from '../model/connection-dto';
@Injectable()
export class GaindeService {
  connectionsSubject=new Subject<any>();  
  metaConnectionSubject=new Subject<any>(); 
  saveConnectSubject=new Subject<boolean>();
  deleteConnectSubject=new Subject<boolean>();
  errorMsgConnectionsSubject=new Subject<string>(); 
  errorConnectionCloseSubject=new Subject<string>(); 
  connectionClosedSubject=new Subject<boolean>();
  tableInfoSubject=new Subject<JSON>();
  tableRowsSubject=new Subject<JSON>();
  tableColumnsSubject=new Subject<JSON[]>();
  errorTableSubject=new Subject<string>(); 
  currentMetaConnection:any;
  currentConnection:ConnectionDTO;
  httpOptions = {
    headers: new HttpHeaders({
      'Accept':  'application/json'     
    })
  };
  constructor(private httpClient:HttpClient) { }
  emitConnectionsSubject(connections:any) {
    this.connectionsSubject.next(connections);
  }
  emitSaveConnectSubject(saveConnect:boolean) {
    this.saveConnectSubject.next(saveConnect);
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
  getAllConnections() {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/all',this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));
        this.emitConnectionsSubject(response);
        },
        (error) => {
          console.log('Erreur ! : ' + error);
        }
      );
      
  }  
  saveConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
       this.emitSaveConnectSubject(true);
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));       
        this.emitSaveConnectSubject(false);
      }
    );    
  }
  updateConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
       this.emitSaveConnectSubject(true);
       
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));        
        this.emitSaveConnectSubject(false);
      }
    );    
  }
  deleteConnection(name:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/connection/'+name,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));
      
       this.emitDeleteConnectSubject(true);
       
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));      
        this.emitDeleteConnectSubject(false);
      }
    );    
  }
  connecToCassandra(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection/connecto',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
      // console.log('response  : ' + JSON.stringify(response));      
       this.getAllMeta(connectionDTO.name);
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error['error'])); 
        console.log('Erreur ! : ' + JSON.stringify(error['error']['error']));   
        this.emitErrorMsgConnectionsSubject(error['error']['error']) ;
        
      }
    );    
  }
  getAllMeta(name:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/metadata/all/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
        // console.log('response  : ' + JSON.stringify(response));   
         this.emitMetaConnectionSubject(response);     
        },
        (error) => {
          console.log('Erreur ! : ' + error);
          this.emitErrorMsgConnectionsSubject(error['error']['error']) ;
        }
      );      
  }  
  closeConnection(name:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/close/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));   
         this.emitConnectionClosedSubject(true);     
        },
        (error) => {
          console.log('Erreur ! : ' + error);
         // this.emitErrorMsgConnectionsSubject(error['error']['error']) ;
         this.emitErrorConnectionClosedSubject(error['error']['error']) ;
        }
      );      
  }  
  getInfoTable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/connection/metadata/table/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));   
         this.emitTableInfoSubject(response);
        },
        (error) => {
          console.log('Erreur ! : ' + error);        
        this.emitErrorTableSubject(error['error']['error']) ;
        }
      );      
  }
  getAllColumns(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON[]>(environment['basePathGainde']+'/connection/metadata/columns/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));   
         this.emitTableColumnsSubject(response);
        },
        (error) => {
          console.log('Erreur ! : ' + error);        
        this.emitErrorTableSubject(error['error']['error']) ;
        }
      );      
  }
  getAllDatas(connectionName:string,keyspace:string,table:string) {   
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
  countLineTable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/connection/table/rows/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         console.log('response  : ' + JSON.stringify(response));   
         this.emitTableRowsSubject(response);
        },
        (error) => {
          console.log('Erreur ! : ' + error);        
          //this.emitErrorTableSubject(error['error']['error']) ;
        }
      );      
  }  
  saveKeyspace(keyspaceDTO){

  }   
}
