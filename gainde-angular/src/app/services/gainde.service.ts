import { Injectable } from '@angular/core';
import {HttpClient,HttpHeaders} from '@angular/common/http';
import {Subject, Observable} from 'rxjs'
import {environment} from '../../environments/environment';
import {ConnectionDTO, KeyspaceDTO,ActionHttp,GaindeCommunication, TableDTO,HistoryDTO} from '../model/model-dto';

@Injectable()
export class GaindeService {
  mapTransfert=new Map<string,any>();
  mapTransfertViewConnectionSubject=new Subject<Map<String,any>>();  
  mapTransfertViewKeyspaceSubject=new Subject<Map<String,any>>();  
  mapTransfertViewAddTableSubject=new Subject<Map<String,any>>();  
  mapTransfertViewEditTableSubject=new Subject<Map<String,any>>();
  notificationDialogImport=new Subject<any>();
  notificationDialogExport=new Subject<any>(); 
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
  emitNotificationDialogImport(content:any) {    
    this.notificationDialogImport.next(content);
  }
  emitNotificationDialogExport(content:any) {    
    this.notificationDialogExport.next(content);
  }
  getAllConnections() {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/all',this.httpOptions)
      .subscribe(
        (response) => {              
           this.emitMapTransfertConnectionsSubject(ActionHttp.ALL_CONNECTION,response);
        },
        (error) => {       
           this.emitMapTransfertConnectionsSubject(ActionHttp.ALL_CONNECTION_ERROR,error['error']['error']);
        }
      );
      
  }  
  saveConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {    
       this.emitMapTransfertConnectionsSubject(ActionHttp.SAVE_CONNECTION,connectionDTO);
      },
      (error) => {           
        this.emitMapTransfertConnectionsSubject(ActionHttp.SAVE_CONNECTION_ERROR,error['error']['error']);
      }
    );    
  }
  updateConnection(connectionDTO:ConnectionDTO){
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/connection',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {          
        
       this.emitMapTransfertConnectionsSubject(ActionHttp.UPDATE_CONNECTION,connectionDTO);  
      },
      (error) => {
    
        this.emitMapTransfertConnectionsSubject(ActionHttp.UPDATE_CONNECTION_ERROR,error['error']['error']);    
       
      }
    );    
  }
  deleteConnection(name:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/connection/'+name,this.httpOptions)
    .subscribe(
      (response) => {            
      
       this.emitMapTransfertConnectionsSubject(ActionHttp.DELETE_CONNECTION,name);  
      },
      (error) => {
           
        this.emitMapTransfertConnectionsSubject(ActionHttp.DELETE_CONNECTION_ERROR,error['error']['error']);  
      }
    );    
  }
  connecToCassandra(connectionDTO:ConnectionDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/connection/connecto',connectionDTO,this.httpOptions)
    .subscribe(
      (response) => {            
     
       this.refreshAllMeta(connectionDTO.name,ActionHttp.CONNECT_TO,true);
      },
      (error) => {     
      
        this.emitMapTransfertConnectionsSubject(ActionHttp.CONNECT_TO_ERROR,error['error']['error']);        
      }
    );    
  }
  getAllMeta(name:string) {   
    this.getAllMetaLocal(name,null);
  }  
  private getAllMetaLocal(name:string,keyspace:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/metadata/all/'+name,this.httpOptions)
      .subscribe(
        (response) => {       

        let responseFormat=response; 
        if(keyspace) {
          responseFormat={'keyspace':keyspace,'response':response};
        }    
         this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_META,responseFormat);       
        },
        (error) => {
               
          this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_META_ERROR,error['error']['error']);        
        }
      );      
  }  
  closeConnection(name:string) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/close/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
        
          this.emitMapTransfertKeyspaceSubject(ActionHttp.CLOSE_CONNECTION,response);   
        },
        (error) => {
       
          this.emitMapTransfertKeyspaceSubject(ActionHttp.CLOSE_CONNECTION_ERROR,error['error']['error']);   
        }
      );      
  }  
  getInfoTable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/connection/metadata/table/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
        
         this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_TABLE,response);   
        },
        (error) => {
        
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_TABLE_ERROR,error['error']['error']);   
        }
      );      
  }
  getInfoTableEdit(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/connection/metadata/table/type/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
        
         this.emitMapTransfertEditTableSubject(ActionHttp.EDIT_TABLE,response);   
        },
        (error) => {
      
          this.emitMapTransfertKeyspaceSubject(ActionHttp.EDIT_TABLE_ERROR,error['error']['error']);   
        }
      );      
  }
  getAllDataTable(connectionName:string,keyspace:string,table:string) {   
    this.httpClient
      .get<JSON[]>(environment['basePathGainde']+'/table/all/'+connectionName+'/'+keyspace+'/'+table,this.httpOptions)
      .subscribe(
        (response) => {               
       
         this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_DATA_TABLE,response);   
        },
        (error) => {
        
          this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_DATA_TABLE_ERROR,error['error']['error']); 
        }
      );      
  } 
  getAllDataPaginate(connectionName:string,keyspace:string,table:string,total:number,pageSate:string,pageNumSate:number, pageSize:number,pageNum:number,isQuery:boolean=false,map:Map<string,string>=null):Observable<JSON[]> {   
   let ultServer=environment['basePathGainde']+'/table/list/'+connectionName+'/'+keyspace+'/'+table+'/'+total+'/'+pageSate+'/'+
   pageNumSate+'/'+pageSize+'/'+pageNum;
   if(!pageSate || pageSate.length==0 || pageNum==1){
    ultServer=environment['basePathGainde']+'/table/list/'+connectionName+'/'+keyspace+'/'+table+'/'+
    pageNumSate+'/'+pageSize+'/'+pageNum;
   }
   if(isQuery){
    let data={};
    if(map){
      map.forEach((value,key)=>{       
        data[key]=value;
      });
      
    }
    return this.httpClient
    .post<JSON[]>(ultServer,data,this.httpOptions);
   }else{
    return this.httpClient
      .get<JSON[]>(ultServer,this.httpOptions);
   }
  } 
  saveKeyspace(connectionName:string,keyspaceDTO:KeyspaceDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName,keyspaceDTO,this.httpOptions)
    .subscribe(
      (response) => {            
     
       this.refreshAllMeta(connectionName,ActionHttp.SAVE_KEYSPACE,false);
      },
      (error) => {
               
         this.emitMapTransfertKeyspaceSubject(ActionHttp.SAVE_KEYSPACE_ERROR,error['error']['error']);  
      }
    );    
  }  
  private refreshAllMeta(name:string,action:ActionHttp,connectTo:boolean) {   
    this.httpClient
      .get<any>(environment['basePathGainde']+'/connection/metadata/all/'+name,this.httpOptions)
      .subscribe(
        (response) => {               
       
        if(connectTo) {
          this.emitMapTransfertConnectionsSubject(action,response);
        }else{
          this.emitMapTransfertKeyspaceSubject(action,response); 
        } 
        },
        (error) => {
           
          this.emitMapTransfertKeyspaceSubject(action,error['error']['error']);  
        }
      );      
  } 
  getKeyspaceInfo(connectionName:string,keyspace) {   
    this.httpClient
      .get<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName+'/'+keyspace,this.httpOptions)
      .subscribe(
        (response) => {               
                    
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_KEYSPACE,response);  
        },
        (error) => {
          
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INFO_KEYSPACE_ERROR,error['error']['error']);  
        }
      );      
  }  
  removeKeySpace(connectionName:string,keyspcaeName:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/keyspace/'+connectionName+'/'+keyspcaeName,this.httpOptions)
    .subscribe(
      (response) => {            
      
       this.refreshAllMeta(connectionName,ActionHttp.REMOVE_KEYSPACE,false);
       
      },
      (error) => {
        
        this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_KEYSPACE_ERROR,error['error']['error']);  
      }
    );    
  }
  removeTable(connectionName:string,keyspcaeName:string,tableName:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/table/'+connectionName+'/'+keyspcaeName+'/'+tableName,this.httpOptions)
    .subscribe(
      (response) => {            
     
       this.refreshAllMeta(connectionName,ActionHttp.REMOVE_TABLE,false); 
      },
      (error) => {
           
         this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_TABLE_ERROR,error['error']['error']);  
      }
    );    
  }
  saveTable(tableDTO:TableDTO,connectionName:string,keyspaceName:string){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/table/'+connectionName+'/'+keyspaceName,tableDTO,this.httpOptions)
    .subscribe(
      (response) => {            
           
        this.emitMapTransfertAddTableSubject(ActionHttp.ADD_TABLE,tableDTO.name);  
      },
      (error) => {     
       
        this.emitMapTransfertAddTableSubject(ActionHttp.ADD_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  insertDataTable(data:any,connectionName:string,keyspaceName:string,tableName:string,bigTable:boolean){
    
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/table/insert/'+connectionName+'/'+keyspaceName+'/'+tableName,data,this.httpOptions)
    .subscribe(
      (response) => {            
      
        if(bigTable) {
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INSERT_BIG_DATA_TABLE,tableName); 
        }else{
          this.emitMapTransfertKeyspaceSubject(ActionHttp.INSERT_DATA_TABLE,tableName); 
        }

      },
      (error) => {     
        
        this.emitMapTransfertKeyspaceSubject(ActionHttp.INSERT_DATA_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  
  updateDataTable(data:any,connectionName:string,keyspaceName:string,tableName:string,bigTable:boolean){
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/table/update/'+connectionName+'/'+keyspaceName+'/'+tableName,data,this.httpOptions)
    .subscribe(
      (response) => {            
       
        if(bigTable) {
          this.emitMapTransfertKeyspaceSubject(ActionHttp.UPDATE_BIG_DATA_TABLE,tableName);
        }else{
          this.emitMapTransfertKeyspaceSubject(ActionHttp.UPDATE_DATA_TABLE,tableName);
        }
      },
      (error) => {     
       
        this.emitMapTransfertKeyspaceSubject(ActionHttp.UPDATE_DATA_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  removeRowDataTable(data:any,connectionName:string,keyspaceName:string,tableName:string,bigData:boolean){
   
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/table/delete/'+connectionName+'/'+keyspaceName+'/'+tableName,data,this.httpOptions)
    .subscribe(
      (response) => {            
      
        if(bigData){    
        this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_ONE_ROW_BIG_DATA,tableName); 
        }else{
          this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_ONE_ROW,tableName); 
        }

      },
      (error) => {     
       
        this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_ONE_ROW_ERROR,error['error']['error']);        
      }
    );    
  }
  removeAllRowDataTable(connectionName:string,keyspaceName:string,tableName:string,bigData:boolean){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/table/delete/all/'+connectionName+'/'+keyspaceName+'/'+tableName,this.httpOptions)
    .subscribe(
      (response) => {            
     
        if(bigData)       {
          this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_ALL_ROWS_BIG_DATA,tableName); 
        }else{
          this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_ALL_ROWS,tableName); 
        }

      },
      (error) => {     
         
        this.emitMapTransfertKeyspaceSubject(ActionHttp.REMOVE_ALL_ROWS_ERROR,error['error']['error']);        
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
         
        this.emitMapTransfertEditTableSubject(ActionHttp.UPDATE_TABLE,tableDTO.name);  
      },
      (error) => {     
       
        this.emitMapTransfertEditTableSubject(ActionHttp.UPDATE_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  orderedConnections(listConnections:Array<ConnectionDTO>){   
    this.httpClient
    .put<JSON>(environment['basePathGainde']+'/connection/ordered/',listConnections,this.httpOptions)
    .subscribe(
      (response) => {            
       
        this.emitMapTransfertEditTableSubject(ActionHttp.ORDERED_CONNECTION,response);   
      },
      (error) => {     
            
        this.emitMapTransfertEditTableSubject(ActionHttp.ORDERED_CONNECTION_ERROR,error['error']['error']);        
      }
    );    
  }
  executeQuery(connectionName:string,keyspaceName:string,query:string){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/table/query/'+connectionName+'/'+keyspaceName,query,this.httpOptions)
    .subscribe(
      (response) => {            
         
        this.emitMapTransfertKeyspaceSubject(ActionHttp.EXECUTE_QUERY,response);
      },
      (error) => {     
             
        this.emitMapTransfertKeyspaceSubject(ActionHttp.EXECUTE_QUERY_ERROR,error['error']['error']);        
      }
    );    
  }
  executeTableWhereQuery(connectionName:string,keyspaceName:string,query:string){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/table/query/'+connectionName+'/'+keyspaceName,query,this.httpOptions)
    .subscribe(
      (response) => {            
          
        this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_DATA_TABLE,response);
      },
      (error) => {     
             
        this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_DATA_TABLE_ERROR,error['error']['error']);        
      }
    );    
  }
  saveQuery(history:HistoryDTO){
    this.httpClient
    .post<JSON>(environment['basePathGainde']+'/history',history,this.httpOptions)
    .subscribe(
      (response) => {            
       
        this.emitMapTransfertKeyspaceSubject(ActionHttp.SAVE_QUERY_HISTORY,response);
      },
      (error) => {     
              
        this.emitMapTransfertKeyspaceSubject(ActionHttp.SAVE_QUERY_HISTORY_ERROR,error['error']['error']);        
      }
    );    
  }
  getAllHistories(all:boolean,connectionName:string) { 
    
    let url= environment['basePathGainde']+'/history'; 
    if(all){
      url=url+'/all';
      }else{
        url=url+'/list/'+connectionName;
      } 
      this.httpClient
      .get<any>(url,this.httpOptions)
      .subscribe(
        (response) => {               
               
           this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_HISTORY,response);
        },
        (error) => {
         
           this.emitMapTransfertKeyspaceSubject(ActionHttp.ALL_HISTORY_ERROR,error['error']['error']);
        }
      );
  }  
  deleteHistory(id:string){
    this.httpClient
    .delete<JSON>(environment['basePathGainde']+'/history/'+id,this.httpOptions)
    .subscribe(
      (response) => {            
     
       this.emitMapTransfertKeyspaceSubject(ActionHttp.DELETE_HISTORY,id);  
      },
      (error) => {
                
        this.emitMapTransfertKeyspaceSubject(ActionHttp.DELETE_HISTORY_ERROR,error['error']['error']);  
      }
    );    
  }
  dumpKeyspace(type:string,connectionName:string,keyspaceName:string) { 
     
     
     let url= environment['basePathGainde']+'/keyspace/dump/{TOKEN}/'+connectionName+'/'+keyspaceName;
     let filename;
     if(type==='3'){
            url=url.replace('{TOKEN}','all');
            filename=keyspaceName+'_schema_with_data.cql';
      }else{
            if(type==='2'){
              url=url.replace('{TOKEN}','data');
                filename=keyspaceName+'_data.cql';
            }else{
                url=url.replace('{TOKEN}','schema');                    
                  filename=keyspaceName+'_schema.cql';
            }
        } 
       this.httpClient
       .get(url,{headers:this.httpOptions.headers, responseType: 'blob' as 'text'})
       .subscribe(
         (response:any) => {   
          let content={'error':false,'msg':''} ;  
          this.emitNotificationDialogExport(content) ;         
          let dataType = response.type;
          let binaryData = [];
          binaryData.push(response);
          let downloadLink = document.createElement('a');
          downloadLink.href = window.URL.createObjectURL(new Blob(binaryData, {type: dataType}));
          if (filename){
              downloadLink.setAttribute('download', filename);
          }
          document.body.appendChild(downloadLink);
          downloadLink.click();
         },
         (error) => {
         
          let content={'error':true,'msg':''} ;  
           this.emitNotificationDialogExport(content) ;        
            this.emitMapTransfertKeyspaceSubject(ActionHttp.DUMP_KEYSPACE_ERROR,error['error']['error']);
         }
       );
   } 
   dumpTable(type:string,connectionName:string,keyspaceName:string,tableName:string) { 
    
     let url= environment['basePathGainde']+'/table/dump/{TOKEN}/'+connectionName+'/'+keyspaceName+'/'+tableName;
     let filename;
        if(type==='3'){
              url=url.replace('{TOKEN}','all');
              filename=tableName+'_schema_with_data.cql';
        }else{
              if(type==='2'){
                url=url.replace('{TOKEN}','data');
                  filename=tableName+'_data.cql';
              }else{
                  url=url.replace('{TOKEN}','schema');                    
                    filename=tableName+'_schema.cql';
              }
          } 
       this.httpClient
       .get(url,{headers:this.httpOptions.headers, responseType: 'blob' as 'text'})
       .subscribe(
         (response:any) => {   
          let content={'error':false,'msg':''} ;  
          this.emitNotificationDialogExport(content) ;         
          let dataType = response.type;
          let binaryData = [];
          binaryData.push(response);
          let downloadLink = document.createElement('a');
          downloadLink.href = window.URL.createObjectURL(new Blob(binaryData, {type: dataType}));
          if (filename){
              downloadLink.setAttribute('download', filename);
          }
          document.body.appendChild(downloadLink);
          downloadLink.click();
         },
         (error) => {
         
          let content={'error':true,'msg':''} ;  
           this.emitNotificationDialogExport(content) ;        
            this.emitMapTransfertKeyspaceSubject(ActionHttp.DUMP_KEYSPACE_ERROR,error['error']['error']);
         }
       );
   }   
   importKeyspace(connectionName:string,formdata:FormData){
    this.httpClient
    .post(environment['basePathGainde']+'/keyspace/import/file/'+connectionName,formdata,this.httpOptions)
    .subscribe(
      (response) => {            
      
        let content={'error':false,'msg':response['message']} ;
        this.emitNotificationDialogImport(content);
      },
      (error) => {
           
       let content={'error':true,'msg':error['error']['error']} ;
       this.emitNotificationDialogImport(content);
      }
    );   
   }
   getAllMetaAfterImport(connectionName:string,keyspaceName:string){
      this.getAllMetaLocal(connectionName,keyspaceName);
   }
  
}
