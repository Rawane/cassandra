import { Component, OnInit } from '@angular/core';
import { TrafficService } from '../services/traffic.service';
import {Subscription} from 'rxjs';
import {Router} from '@angular/router';
import {NestedTreeControl} from '@angular/cdk/tree';
import {MatTreeNestedDataSource} from '@angular/material/tree';
interface Filter {
  name:string;
  execTime:number;
  espk:string;
  type:string,
  class:string,
  status:string,
  filterTime:number;
  filters:Filter[];
}
@Component({
  selector: 'app-detail-traffic',
  templateUrl: './detail-traffic.component.html',
  styleUrls: ['./detail-traffic.component.scss']
})
export class DetailTrafficComponent implements OnInit {
traffic;
trafficDetailAll: any[];
traceTraffic:any[];
policeTraffic:any[];
detailTrafficAllSubscription:Subscription;
trafficGateway:string;
trafficGatewayLeg=new Map<string, string>();
currentLeg:string;
trafficGatewaySubscription:Subscription;
traceTrafficSubscription:Subscription;
policeTrafficSubscription:Subscription;
policeShow=false;
treeControl = new NestedTreeControl<Filter>(node => node.filters);
dataSource = new MatTreeNestedDataSource<Filter>();
hasChild = (_: number, node: Filter) => !!node.filters && node.filters.length > 0;
  constructor(private trafficService:TrafficService,private router:Router) { 

  }

  ngOnInit() {  
    this.detailTrafficAllSubscription=this.trafficService.detailTrafficAllSubject.subscribe((result: any) => {      
      this.trafficDetailAll = result;     
     if(this.trafficDetailAll){
        this.trafficDetailAll.sort((a,b) => a.details.leg - b.details.leg );
     }
      
    });   
    this.trafficGatewaySubscription=this.trafficService.contentTransportSubject.subscribe((result: string) => {
      this.trafficGateway=result;
      this.trafficGatewayLeg.set(this.currentLeg,result);     
    });  
    this.traceTrafficSubscription=this.trafficService.traceTrafficSubject.subscribe((result: any) => {      
      this.traceTraffic = result;      
    });  
    this.policeTrafficSubscription=this.trafficService.policeTrafficSubject.subscribe((result: any) => {      
      let resString:string=JSON.stringify(result);
      resString=resString.replace(new RegExp('policy','g'),'name').replace(new RegExp('subPaths','g'),'filters');
      this.dataSource.data=JSON.parse(resString);    
      /*setTimeout(() => {        this.treeControl.expandAll();        }, 2000);*/
      
    }); 
    
    this.traffic=this.trafficService.currentTraffic.traffic;    
    let env=this.trafficService.currentTraffic.env;
    let instanceId=this.trafficService.currentTraffic.instanceId;
    if(this.traffic){      
      this.trafficService.showDetailTrafficAll(env,instanceId,this.traffic);
    }else{
      this.router.navigate(['/view-traffic']);
    }
  }
  onBack(){
    this.trafficService.manageBack=true;   
   this.router.navigate(['/view-traffic']);
  }
  onShowPolice(){
    this.policeShow=!this.policeShow;   
    if(!this.traceTraffic && this.policeShow){
      this.traffic=this.trafficService.currentTraffic.traffic;    
      let env=this.trafficService.currentTraffic.env;
      let instanceId=this.trafficService.currentTraffic.instanceId;
      this.trafficService.showPolicePath(env,instanceId,this.traffic);  
    
    }
  }
  onOpenContentReceived(leg:number){
    this.currentLeg='REC'+leg;
      if(!this.trafficGatewayLeg.get(this.currentLeg)){
          this.traffic=this.trafficService.currentTraffic.traffic;    
          let env=this.trafficService.currentTraffic.env;
          let instanceId=this.trafficService.currentTraffic.instanceId;
          if(this.traffic){
            //this.router.navigate(['/view-traffic']);
            this.trafficService.showDataContentReceivedGatway(env,instanceId,this.traffic,leg);
              
          }
      }
  }
  onOpenContentSent(leg:number){
    this.currentLeg='SENT'+leg;
    if(!this.trafficGatewayLeg.get('SENT'+leg) ){
        this.traffic=this.trafficService.currentTraffic.traffic;    
        let env=this.trafficService.currentTraffic.env;
        let instanceId=this.trafficService.currentTraffic.instanceId;
        if(this.traffic){
          //this.router.navigate(['/view-traffic']);
          this.trafficService.showDataContentSentGatway(env,instanceId,this.traffic,leg);     
        } 
    }
  }
  onShowTrace(){
    if(!this.traceTraffic){
      this.traffic=this.trafficService.currentTraffic.traffic;    
      let env=this.trafficService.currentTraffic.env;
      let instanceId=this.trafficService.currentTraffic.instanceId;
      this.trafficService.showTrace(env,instanceId,this.traffic);     
    }
  }
}
