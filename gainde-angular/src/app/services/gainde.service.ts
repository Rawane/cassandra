import { Injectable } from '@angular/core';
import {HttpClient,HttpHeaders} from '@angular/common/http';
import {Subject} from 'rxjs'
import {environment} from '../../environments/environment';
import {ConnectionDTO, KeyspaceDTO,ActionHttp,GaindeCommunication, TableDTO} from '../model/model-dto';

@Injectable()
export class GaindeService {
  mapTransfert=new Map<string,any>();
  mapTransfertViewConnectionSubject=new Subject<Map<String,any>>();  
  mapTransfertViewKeyspaceSubject=new Subject<Map<String,any>>();  
  mapTransfertViewAddTableSubject=new Subject<Map<String,any>>();  
  mapTransfertViewEditTableSubject=new Subject<Map<String,any>>();
  //currentMetaConnection:any;
  //currentConnection:ConnectionDTO;
  currentGainde:GaindeCommunication=new GaindeCommunication();
  httpOptions = {
    headers: new HttpHeaders({
      'Accept':  'application/json'     
    })
  };
  constructor(private httpClient:HttpClient) { }
  
  emitMapTransfertConnectionsSubject(action:ActionHttp,content:any) {
    this.mapTransfert.set("content",content);
    this.mapTransfert.set("type",action);
    this.mapTransfertViewConnectionSubject.next(this.mapTransfert);
  }
  emitMapTransfertKeyspaceSubject(action:ActionHttp,content:any) {
    this.mapTransfert.set("content",content);
    this.mapTransfert.set("type",action);
    this.mapTransfertViewKeyspaceSubject.next(this.mapTransfert);
  }  
  emitMapTransfertEditTableSubject(action:ActionHttp,content:any) {
    this.mapTransfert.set("content",content);
    this.mapTransfert.set("type",action);
    this.mapTransfertViewEditTableSubject.next(this.mapTransfert);
  }
  emitMapTransfertAddTableSubject(action:ActionHttp,content:any) {
    this.mapTransfert.set("content",content);
    this.mapTransfert.set("type",action);
    this.mapTransfertViewAddTableSubject.next(this.mapTransfert);
  }
  getAllConnections() {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/all',this.httpOptions)
      .subscribe(
        (response) => {               
        //console.log('response  : ' + JSON.stringify(response));            
           this.emitMapTransfertConnectionsSubject(ActionHttp.ALL_CONNECTION,response);
        },
        (error) => {
          console.log('Erreur ! : ' + error);         
           this.emitMapTransfertConnectionsSubject(ActionHttp.ALL_CONNECTION_ERROR,error['error']['error']);
        }
      );
      
  }  
  saveConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
       this.emitMapTransfertConnectionsSubject(ActionHttp.SAVE_CONNECTION,connectionDTO);
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));          
        this.emitMapTransfertConnectionsSubject(ActionHttp.SAVE_CONNECTION_ERROR,error['error']['error']);
      }
    );    
  }
  updateConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));         
       this.emitMapTransfertConnectionsSubject(ActionHttp.UPDATE_CONNECTION,connectionDTO);  
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error)); 
        this.emitMapTransfertConnectionsSubject(ActionHttp.UPDATE_CONNECTION_ERROR,error['error']['error']);    
       
      }
    );    
  }
  deleteConnection(name:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/connection/'+name,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));   
       this.emitMapTransfertConnectionsSubject(ActionHttp.DELETE_CONNECTION,name);  
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));            
        this.emitMapTransfertConnectionsSubject(ActionHttp.DELETE_CONNECTION_ERROR,error['error']['error']);  
      }
    );    
  }
  connecToCassandra(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection/connecto',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
      // console.log('response  : ' + JSON.stringify(response));      
       this.refreshAllMeta(connectionDTO.name,ActionHttp.CONNECT_TO,true);
      },
      (error) => {     
        console.log('Erreur ! : ' + JSON.stringify(error['error']['error']));          
        this.emitMapTransfertConnectionsSubject(ActionHttp.CONNECT_TO_ERROR,error['error']['error']);        
      }
    );    
  }
  getAllMeta(name:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/metadata/all/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
        // console.log('response  : ' + JSON.stringify(response));       
         this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_META,response);       
        },
        (error) => {
          console.log('Erreur ! : ' + error);           
          this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_META_ERROR,error['error']['error']);        
        }
      );      
  }  
  closeConnection(name:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/close/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
          console.log('response  : ' + JSON.stringify(response));     
          this.emitMapTransfertKeyspaceSubject(ActionHttp.CLOSE_CONNECTION,response);   
        },
        (error) => {
          console.log('Erreur ! : ' + error);
          this.emitMapTransfertKeyspaceSubject(ActionHttp.CLOSE_CONNECTION_ERROR,error['error']['error']);   
        }
      );      
  }  
  getInfoTable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/connection/metadata/table/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         //console.log('response  : ' + JSON.stringify(response));   
         this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_TABLE,response);   
        },
        (error) => {
          console.log('Erreur ! : ' + error['error']['error']);
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_TABLE_ERROR,error['error']['error']);   
        }
      );      
  }
  getInfoTableEdit(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/connection/metadata/table/type/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         //console.log('response  : ' + JSON.stringify(response));   
         this.emitMapTransfertEditTableSubject(ActionHttp.EDIT_TABLE,response);   
        },
        (error) => {
          console.log('Erreur ! : ' + error['error']['error']);
          this.emitMapTransfertKeyspaceSubject(ActionHttp.EDIT_TABLE_ERROR,error['error']['error']);   
        }
      );      
  }
  getAllDataTable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON[]>(environment['basePathGainde']+'/table/all/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
         //console.log('response  : ' + JSON.stringify(response));   
         this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_DATA_TABLE,response);   
        },
        (error) => {
          console.log('Erreur ! : ' + error);        
          this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_DATA_TABLE_ERROR,error['error']['error']); 
        }
      );      
  } 
  saveKeyspace(connectionName:string,keyspaceDTO:KeyspaceDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName,keyspaceDTO,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));       
       this.refreshAllMeta(connectionName,ActionHttp.SAVE_KEYSPACE,false);
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));          
         this.emitMapTransfertKeyspaceSubject(ActionHttp.SAVE_KEYSPACE_ERROR,error['error']['error']);  
      }
    );    
  }  
  private refreshAllMeta(name:string,action:ActionHttp,connectTo:boolean) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/metadata/all/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
        // console.log('response  : ' + JSON.stringify(response));
        if(connectTo) {
          this.emitMapTransfertConnectionsSubject(action,response);
        }else{
          this.emitMapTransfertKeyspaceSubject(action,response); 
        } 
        },
        (error) => {
          console.log('Erreur ! : ' + error);              
          this.emitMapTransfertKeyspaceSubject(action,error['error']['error']);  
        }
      );      
  } 
  getKeyspaceInfo(connectionName:string,keyspace) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName+'/'+keyspace,this.httpOptions)
      .subscribe(
        (response) => {               
          // console.log('response  : ' + JSON.stringify(response));                 
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_KEYSPACE,response);  
        },
        (error) => {
          console.log('Erreur ! : ' + error);
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_KEYSPACE_ERROR,error['error']['error']);  
        }
      );      
  }  
  removeKeySpace(connectionName:string,keyspcaeName:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName+'/'+keyspcaeName,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));      
       this.refreshAllMeta(connectionName,ActionHttp.REMOVE_KEYSPACE,false);
       
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));      
        this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_KEYSPACE_ERROR,error['error']['error']);  
      }
    );    
  }
  removeTable(connectionName:string,keyspcaeName:string,tableName:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/table/'+connectionName+'/'+keyspcaeName+'/'+tableName,this.httpOptions)
    .subscribe(
      (response) => {            
       console.log('response  : ' + JSON.stringify(response));  
       this.refreshAllMeta(connectionName,ActionHttp.REMOVE_TABLE,false); 
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));          
         this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_TABLE_ERROR,error['error']['error']);  
      }
    );    
  }
  saveTable(tableDTO:TableDTO,connectionName:string,keyspaceName:string){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/table/'+connectionName+'/'+keyspaceName,tableDTO,this.httpOptions)
    .subscribe(
      (response) => {            
        console.log('response  : ' + JSON.stringify(response));        
        this.emitMapTransfertAddTableSubject(ActionHttp.ADD_TABLE,tableDTO.name);  
      },
      (error) => {     
        console.log('Erreur ! : ' + JSON.stringify(error['error']['error']));          
        this.emitMapTransfertAddTableSubject(ActionHttp.ADD_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  insertDataTable(data:any,connectionName:string,keyspaceName:string,tableName:string){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/table/insert/'+connectionName+'/'+keyspaceName+'/'+tableName,data,this.httpOptions)
    .subscribe(
      (response) => {            
        console.log('response  : ' + JSON.stringify(response));        
        this.emitMapTransfertKeyspaceSubject(ActionHttp.INSERT_DATA_TABLE,tableName); 

      },
      (error) => {     
        console.log('Erreur ! : ' + JSON.stringify(error['error']['error']));          
        this.emitMapTransfertKeyspaceSubject(ActionHttp.INSERT_DATA_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  updateDataTable(data:any,connectionName:string,keyspaceName:string,tableName:string){
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/table/update/'+connectionName+'/'+keyspaceName+'/'+tableName,data,this.httpOptions)
    .subscribe(
      (response) => {            
        console.log('response  : ' + JSON.stringify(response));        
        this.emitMapTransfertKeyspaceSubject(ActionHttp.UPDATE_DATA_TABLE,tableName); 

      },
      (error) => {     
        console.log('Erreur ! : ' + JSON.stringify(error['error']['error']));          
        this.emitMapTransfertKeyspaceSubject(ActionHttp.UPDATE_DATA_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  updateTable(oldTableDTO:TableDTO,tableDTO:TableDTO,connectionName:string,keyspaceName:string){
    let coupleTableDTO={
      "oldTableDTO":oldTableDTO,
      "tableDTO":tableDTO
    }
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/table/'+connectionName+'/'+keyspaceName,coupleTableDTO,this.httpOptions)
    .subscribe(
      (response) => {            
        console.log('response  : ' + JSON.stringify(response));        
        this.emitMapTransfertEditTableSubject(ActionHttp.UPDATE_TABLE,tableDTO.name);  
      },
      (error) => {     
        console.log('Erreur ! : ' + JSON.stringify(error['error']['error']));          
        this.emitMapTransfertEditTableSubject(ActionHttp.UPDATE_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  
  testCSPGateway(){
   
    this.httpOptions.headers=this.httpOptions.headers.set('Accept','*/*');
    //this.httpOptions.headers=this.httpOptions.headers.set('Authorization','azazazazazazaza');
   // this.httpOptions.headers=this.httpOptions.headers.set('test-header','test');
    this.httpClient
    .get('https://api-mig.gidn.urssaf.fr/api/reporting/page.html',{headers:this.httpOptions.headers, responseType: 'text' as 'text'})
    .subscribe(
      (response) => {       
        console.log('Response ! : ' + JSON.stringify(response));
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));
      }
    );
  }
}
