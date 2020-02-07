import { Injectable } from '@angular/core';
import {HttpClient,HttpHeaders} from '@angular/common/http';
import {Subject,forkJoin,of} from 'rxjs';
import {catchError} from 'rxjs/operators'

import {environment} from '../../environments/environment';
import {FormSearch} from '../model/form-search.model';
@Injectable()
export class TrafficService {
  manageBack=false;
 topology:JSON;
 resultSearch:JSON;
 detailTraffic:JSON;
 detailTrafficAll:JSON;
 traceTraffic:any[];
 policeTraffic:any[];
 contentTransport:string;
 detailTrafficSubject=new Subject<JSON>();
 detailTrafficAllSubject=new Subject<JSON>();
 contentTransportSubject=new Subject<string>();
 resultSearchSubject=new Subject<JSON>();
 resultErrorSubject=new Subject<boolean>();
 instanceDmzSubject=new Subject<any[]>();
 instanceDmz=[];
 instanceIntra=[];
 mapInstance = new Map();
 traceTrafficSubject=new Subject<any[]>();
 instanceIntraSubject=new Subject<any[]>();
 policeTrafficSubject=new Subject<any[]>();
 searchFormBackup; 
 currentTraffic={
   traffic:'',
   env:'',
   instanceId:''
 };
 httpOptions = {
  headers: new HttpHeaders({
    'Accept':  'application/json',
    'Authorization': 'Basic QUM3NTA5NDUwODpNYW1hbmF0YXRlITIzMDc='
  })
};
  constructor(private httpClient:HttpClient) {
    
   }
   testCorsGateway() { 
    let httpOptionsT = {
      headers: new HttpHeaders({
        'Content-Type':  'application/x-www-form-urlencoded',
        'sdsdsdsdsd': 'QUM3NTA5NDUwODpNYW1hbmF0YXRlITIzMDc=',
        'Test': 'azazzzaazza',
        'Cookies': 'sddsdssdd'
       
      })
    };
    this.httpClient
      .post<JSON>('https://api-mig.gidn.urssaf.fr/api/oauth/v1/token','grant_type=password&client_id=6154a600-3f5e-4816-817f-eda2712f8e31&client_secret=cdec2991-a0c0-45ce-8b5f-9f999fd31546&username=1720440192018&password=cnv33000&scope=teledep.declaration teledep.mandat',httpOptionsT)
      .subscribe(
        (response) => {            
         console.log('response  : ' + JSON.stringify(response));
         
        },
        (error) => {
          console.log('Erreur ! : ' + error);
        }
      );     
      
  }  
  getTopologyByEnv(envSelect:string) {    
   
    this.httpClient
      .get<JSON>(environment['basePathApiGateway']+envSelect+environment.pathTopology,this.httpOptions)
      .subscribe(
        (response) => {
          this.topology = response;         
         // console.log('response  : ' + JSON.stringify(this.topology));
          this.buildInstance();
        },
        (error) => {
          console.log('Erreur ! : ' + error);
        }
      );     
      
  }  
  private buildInstance() {
    this.instanceDmz=[];
    this.instanceIntra=[];
    let groups = this.topology['result']['groups'];
    for (let index in groups) {    
      if (groups[index]['name'] === 'DMZ') {
        let services=groups[index]['services'];
        for(let indexSer in services){
          let instanceUnit={id:services[indexSer]['id'],name:services[indexSer]['name']}
          this.instanceDmz.push(instanceUnit);
          this.mapInstance.set(instanceUnit.name,instanceUnit.id);
        }
        this.emitInstanceDmzSubject();
      }
      if (groups[index]['name'] === 'INTRA') {
        let services=groups[index]['services'];
        for(let indexSer in services){         
          let instanceUnit={id:services[indexSer]['id'],name:services[indexSer]['name']}
          this.instanceIntra.push(instanceUnit);
          this.mapInstance.set(instanceUnit.name,instanceUnit.id);
        }
        this.emitInstanceIntraSubject();
      }
    }   
  }
  getInstanceByName(name:string){
    return this.mapInstance.get(name);
  }
  emitInstanceDmzSubject() {
    this.instanceDmzSubject.next(this.instanceDmz.slice());
  }
  emitDetailTrafficSubject() {
    this.detailTrafficSubject.next(this.detailTraffic);
  }
  emitDetailTrafficAllSubject() {
    this.detailTrafficAllSubject.next(this.detailTrafficAll);
  }
  emitContentTransportSubject() {
    this.contentTransportSubject.next(this.contentTransport);
  } 
  emitTraceTrafficSubject() {
    this.traceTrafficSubject.next(this.traceTraffic);
  }
  emitResultErrorSubject() {
    this.resultErrorSubject.next(true);
  }
  emitResultSearchSubject() {
    if(this.resultSearch && this.resultSearch['data']){
      //copie de la liste
      let arrayTemp=[];
      for(let i in this.resultSearch['data']){        
        let traffic=this.resultSearch['data'][i];      
        arrayTemp[i]=this.resultSearch['data'][i];
      }
     for(let i in arrayTemp){
        let traffic=arrayTemp[i];
        this.resultSearch['data'].forEach((item,index) =>{       
          if(item['uri']==='/technique/v1/healthcheck'){
            this.resultSearch['data'].splice(index,1);
        }
        });       
    }
    this.resultSearchSubject.next(this.resultSearch);
  }
}
emitPoliceTrafficSubject() {
  this.policeTrafficSubject.next(this.policeTraffic);
}
emitInstanceIntraSubject() {
  this.instanceIntraSubject.next(this.instanceIntra.slice());
}
  private  buildQuerySearch(formSearch:FormSearch):string {
    if(!formSearch.transactionId || formSearch.transactionId.length==0){
        let query='&ago='+formSearch.timeInterval+'&count='+formSearch.maxResults;        
        if(formSearch.path && formSearch.path.length!=0){
          query=query+'&field=uri&value='+encodeURI(formSearch.path);
        }
        if(formSearch.method && formSearch.method.length!=0){
          query=query+'&field=method&value='+formSearch.method;
        }
        if(formSearch.transactionStatus && formSearch.transactionStatus.length!=0){
          query=query+'&field=finalStatus&value='+formSearch.transactionStatus;
        }
        if(formSearch.durationIn && formSearch.durationIn.length!=0){
          query=query+'&field=duration&op='+formSearch.duration+'&value='+formSearch.durationIn;
        }
        if(formSearch.status && formSearch.status.length!=0){
          query=query+'&field=status&value='+formSearch.status;
        }
        if(formSearch.subject && formSearch.subject.length!=0){
          query=query+'&field=subject&value='+formSearch.subject;
        }   
        console.log('buildQuerySearch '+query) ;
        return query;
   }else{
        return '&field=correlationId&value='+formSearch.transactionId;
   }
  }
  private  buildBasePathSearch(formSearch:FormSearch,instanceId:string):string{
    return environment['basePathApiGateway']+formSearch.environnement+environment.pathSearchTraffic.replace('{instance}',instanceId);

  }
  //Début pour ecran detail traffic
  showDetailTraffic(envSelected:string,instance:string,traffic:JSON){
    let uri=environment['basePathApiGateway']+envSelected+environment.pathServiceHeaderTraffic.
    replace('{instance}',instance).replace('{correlationId}',traffic['correlationId']).
    replace('{INDEX}','0');
    this.httpClient
    .get<JSON>(uri,this.httpOptions)
    .subscribe(
      (response) => {        
        this.detailTraffic=response;
        this.emitDetailTrafficSubject();
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));
      }
    );
  }
  showDetailTrafficAll(envSelected:string,instance:string,traffic:JSON){
    let uri=environment['basePathApiGateway']+envSelected+environment.pathServiceHeaderTraffic.
    replace('{instance}',instance).replace('{correlationId}',traffic['correlationId']).
    replace('{INDEX}','*');
    this.httpClient
    .get<JSON>(uri,this.httpOptions)
    .subscribe(
      (response) => {      
        this.detailTrafficAll=response;
        this.emitDetailTrafficAllSubject();
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));
      }
    );
  }
  showDataContentReceivedGatway(envSelected:string,instance:string,traffic:JSON,leg:number){
    if(leg===0){
      this.showDetailContentReceive(envSelected,instance,traffic,leg);
    }else{
      this.showDetailContentSent(envSelected,instance,traffic,leg); 
    }
  }
  showDataContentSentGatway(envSelected:string,instance:string,traffic:JSON,leg:number){
    if(leg===0){
      this.showDetailContentSent(envSelected,instance,traffic,leg);
    }else{
      this.showDetailContentReceive(envSelected,instance,traffic,leg); 
    }
  }
  private showDetailContentReceive(envSelected:string,instance:string,traffic:JSON,leg:number){
    let uri=environment['basePathApiGateway']+envSelected+environment.pathServiceContentReceive.
    replace('{instance}',instance).replace('{correlationId}',traffic['correlationId']).
    replace('{INDEX}',''+leg);
    this.httpOptions.headers=this.httpOptions.headers.set('Accept','*/*');
  
    this.httpClient
    .get(uri,{headers:this.httpOptions.headers, responseType: 'text' as 'text'})
    .subscribe(
      (response) => {       
        this.contentTransport=response;
        this.emitContentTransportSubject();
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));
      }
    );
  }

  private showDetailContentSent(envSelected:string,instance:string,traffic:JSON,leg:number){
    let uri=environment['basePathApiGateway']+envSelected+environment.pathServiceContentSent.
    replace('{instance}',instance).replace('{correlationId}',traffic['correlationId']).
    replace('{INDEX}',''+leg);
    this.httpOptions.headers=this.httpOptions.headers.set('ACCEPT','*/*');
    this.httpClient
    .get(uri,{headers:this.httpOptions.headers, responseType: 'text' as 'text'})
    .subscribe(
      (response) => {       
        this.contentTransport=response;
        this.emitContentTransportSubject();
      },
      (error) => {
        console.log('Erreur ! : ' + error);
      }
    );
  }
  showTrace(envSelected:string,instance:string,traffic:JSON){
    let uri=environment['basePathApiGateway']+envSelected+environment.pathServiceTrace.
    replace('{instance}',instance).replace('{correlationId}',traffic['correlationId']);  
    this.httpClient
    .get<any[]>(uri,this.httpOptions)
    .subscribe(
      (response) => {      
        this.traceTraffic=response;
        this.emitTraceTrafficSubject();
      },
      (error) => {
       console.log('Erreur ! : ' + JSON.stringify(error));
      }
    );
  }
  showPolicePath(envSelected:string,instance:string,traffic:JSON){
    let uri=environment['basePathApiGateway']+envSelected+environment.pathServiceCircuitpath.
    replace('{instance}',instance).replace('{correlationId}',traffic['correlationId']);  
    this.httpClient
    .get<any[]>(uri,this.httpOptions)
    .subscribe(
      (response) => {       
        this.policeTraffic=response;        
        this.emitPoliceTrafficSubject();
      },
      (error) => {
        console.log('Erreur ! : ' + JSON.stringify(error));
      }
    );
  }
  //Fin ecran detail traffic
  //pour ecran view traffic
  stopTraffic(envSelected:string){
    this.httpClient
    .get<JSON>(environment['basePathApiTraffic']+envSelected+'/stop/',this.httpOptions)
    .subscribe(
      (response) => {
        console.log('stopTraffic Yess : ');
      },
      (error) => {
        console.log('Erreur ! : ' + error);
      }
    );
  }
  startTraffic(envSelected:string){
    this.httpClient
    .get<JSON>(environment['basePathApiTraffic']+envSelected+'/start/',this.httpOptions)
    .subscribe(
      (response) => {
        console.log('startTraffic Yess : ');
      },
      (error) => {
        console.log('Erreur ! : ' + error);
      }
    );
  }
  searchByHeaderAuthorization(authorization:string,envSelected:string){
    console.log('searchByHeaderAuthorization  ! : ' + authorization);    
    this.httpClient
    .get<JSON>(environment['basePathApiTraffic']+envSelected+'/list/'+authorization,this.httpOptions)
    .subscribe(
      (response) => {
        this.resultSearch = response;       
        if(this.resultSearch && this.resultSearch['data']){        
         this.emitResultSearchSubject();
        }       
       
      },
      (error) => {
        console.log('Erreur ! : ' + error);
      }
    );
  }
  search(formSearch:FormSearch){
    console.log("search form "+JSON.stringify(formSearch));
    console.log("search instance dmz "+JSON.stringify(this.instanceDmz)+' intra '+JSON.stringify(this.instanceIntra));   
    let observableResults=[];
    let arrayInstance=[];
    let arrayGroup=[];
    switch (formSearch.topology) {
      case 'Tous': {
        this.instanceDmz.forEach( 
          instance =>{
            arrayGroup.push('DMZ');
            arrayInstance.push(instance.name);
            this.httpOptions.headers=this.httpOptions.headers.set('X_GROUP_TOPOLOGIE','DMZ');
            this.httpOptions.headers= this.httpOptions.headers.set('X_GROUP_INSTANCE',instance.name);
            let basePath:string=this.buildBasePathSearch(formSearch,instance.id);
            //basePath='http://localhost:8080/gateway/test'+environment.pathSearchTraffic.replace('{instance}',instance.id);
            observableResults.push(this.httpClient
              .get<JSON>(basePath+this.buildQuerySearch(formSearch),this.httpOptions).pipe(catchError(error =>of('{"error",true}'))));
          });     
        this.instanceIntra.forEach(        
            instance =>{
              arrayGroup.push('INTRA');
              arrayInstance.push(instance.name);
              this.httpOptions.headers=this.httpOptions.headers.set('X_GROUP_TOPOLOGIE','INTRA');
              this.httpOptions.headers= this.httpOptions.headers.set('X_GROUP_INSTANCE',instance.name);
              let basePath:string=this.buildBasePathSearch(formSearch,instance.id);
              //basePath='http://localhost:8080/gateway/test'+environment.pathSearchTraffic.replace('{instance}',instance.id);
              observableResults.push(this.httpClient
                .get<JSON>(basePath+this.buildQuerySearch(formSearch),this.httpOptions).pipe(catchError(error =>of('{"error",true}'))));
             
            });
        let resTraffic=[];
        this.resultSearch= JSON.parse('{ "data":[]}');       
        forkJoin(observableResults).subscribe(results => {
           results.forEach((result,index) =>{    
             console.log('observableResults result '+result);         
             if( result && result['data']){                     
                 result['data'].forEach(traffic=>{
                   traffic['group']=arrayGroup[index];
                   traffic['server']=arrayInstance[index];             
                 });
              resTraffic=[].concat(resTraffic,result['data']);
           }
           });
           this.resultSearch['data']=resTraffic;          
           this.emitResultSearchSubject();
        });
        break;
        }
       
      case 'DMZ':{        
        if(formSearch.instanceName==='Tous'){        
          this.instanceDmz.forEach( 
          instance =>{
            arrayGroup.push('DMZ');
            arrayInstance.push(instance.name);
            this.httpOptions.headers=this.httpOptions.headers.set('X_GROUP_TOPOLOGIE','DMZ');
            this.httpOptions.headers= this.httpOptions.headers.set('X_GROUP_INSTANCE',instance.name);
            let basePath:string=this.buildBasePathSearch(formSearch,instance.id);
            observableResults.push(this.httpClient
              .get<JSON>(basePath+this.buildQuerySearch(formSearch),this.httpOptions).pipe(catchError(error =>of('{"error",true}'))));;         
          });   
          let resTraffic=[];
          this.resultSearch= JSON.parse('{ "data":[]}');
        
          forkJoin(observableResults).subscribe(results => {
             results.forEach((result,index) =>{
              if( result && result['data']){
                 result['data'].forEach(traffic=>{
                    traffic['group']=arrayGroup[index];
                   traffic['server']=arrayInstance[index];
                 });
                 resTraffic=[].concat(resTraffic,result['data']);
              }else{ 
                if(result['error']){
                 this.emitResultErrorSubject();
                } 
              }
             });
             this.resultSearch['data']=resTraffic;
             this.emitResultSearchSubject();
          });  
        }else{
          for (let i = 0; i < this.instanceDmz.length ; i++) {     
            if(this.instanceDmz[i].name===formSearch.instanceName) {               
              this.httpOptions.headers=this.httpOptions.headers.set('X_GROUP_TOPOLOGIE','DMZ');
              this.httpOptions.headers= this.httpOptions.headers.set('X_GROUP_INSTANCE',this.instanceDmz[i].name);  
              let basePath:string=this.buildBasePathSearch(formSearch,this.instanceDmz[i].id);              
              this.httpClient
              .get<JSON>(basePath+this.buildQuerySearch(formSearch),this.httpOptions)
              .subscribe(
                (response) => {
                  this.resultSearch = response;     
                  if(this.resultSearch && this.resultSearch['data']){            
                  this.resultSearch['data'].forEach((traffic,index) =>{                     
                    traffic['group']='DMZ';
                    traffic['server']=this.instanceDmz[i].name;
                   }); 
                   this.emitResultSearchSubject();
                  }       
                 
                },
                (error) => {
                  console.log('Erreur ! : ' + error);
                  this.emitResultErrorSubject();
                }
              );
            }
          }
        }
        break;
      }
      case 'INTRA':{
       
        if(formSearch.instanceName==='Tous'){
        this.instanceIntra.forEach( 
        instance =>{
          arrayGroup.push('INTRA');
          arrayInstance.push(instance.name);
          this.httpOptions.headers=this.httpOptions.headers.set('X_GROUP_TOPOLOGIE','INTRA');
          this.httpOptions.headers= this.httpOptions.headers.set('X_GROUP_INSTANCE',instance.name);  
          let basePath:string=this.buildBasePathSearch(formSearch,instance.id);
          observableResults.push(this.httpClient
            .get<JSON>(basePath+this.buildQuerySearch(formSearch),this.httpOptions).pipe(catchError(error =>of('{"error",true}'))));         
        });   
        let resTraffic=[];
        this.resultSearch= JSON.parse('{ "data":[]}');
      
        forkJoin(observableResults).subscribe(results => {
           results.forEach((result,index) =>{
            if(result['data']){
            result['data'].forEach(traffic=>{
              traffic['group']=arrayGroup[index];
              traffic['server']=arrayInstance[index];
            });
              resTraffic=[].concat(resTraffic,result['data']);
          }else{
            if(result['error']){
                this.emitResultErrorSubject();
            }
          }
           });
           this.resultSearch['data']=resTraffic;
           this.emitResultSearchSubject();
        });  
      }else{
        for (let i = 0; i < this.instanceIntra.length ; i++) {     
          if(this.instanceIntra[i].name===formSearch.instanceName) {              
            this.httpOptions.headers=this.httpOptions.headers.set('X_GROUP_TOPOLOGIE','INTRA');
            this.httpOptions.headers= this.httpOptions.headers.set('X_GROUP_INSTANCE',this.instanceIntra[i].name);  
            let basePath:string=this.buildBasePathSearch(formSearch,this.instanceIntra[i].id);
            this.httpClient
            .get<JSON>(basePath+this.buildQuerySearch(formSearch),this.httpOptions)
            .subscribe(
              (response) => {
                this.resultSearch = response;  
                if(this.resultSearch && this.resultSearch['data']) {                   
                this.resultSearch['data'].forEach((traffic,index) =>{                     
                  traffic['group']='INTRA';
                  traffic['server']=this.instanceIntra[i].name;
               });              
                this.emitResultSearchSubject();
              }
              },
              (error) => {
                console.log('Erreur ! : ' + error);
                this.emitResultErrorSubject();
              }
            );
          }
        }
      }
        break;
    }
      default:
        break;
    } 
  }
}
