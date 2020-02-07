import { Component, OnInit,ViewChild,AfterViewInit } from '@angular/core';
import {Router} from '@angular/router';
import {FormGroup,FormBuilder,Validators} from '@angular/forms'; 
import {Observable,Subscription,forkJoin,Subject,of} from 'rxjs';
import {map, startWith} from 'rxjs/operators';
import {MatTableDataSource} from '@angular/material/table';
import {MatPaginator} from '@angular/material/paginator';
import {MatSort} from '@angular/material/sort';
import {FormSearch} from '../model/form-search.model';
import { TrafficService } from '../services/traffic.service';

@Component({
  selector: 'app-view-traffic',
  templateUrl: './view-traffic.component.html',
  styleUrls: ['./view-traffic.component.scss']
})
export class ViewTrafficComponent implements OnInit,AfterViewInit  {
 searchForm:FormGroup; 
 //trafficDataSo:JSON;
 trafficDataSource=new MatTableDataSource<JSON>();
 @ViewChild(MatPaginator, {static: false}) paginator: MatPaginator;
 @ViewChild(MatSort, {static: false}) sort: MatSort;
 resultsLength = 0;
 isLoading=true;
 trafficDataSourceSubscription:Subscription;
 searchErrorSubscription:Subscription;
 instanceDmz=[];
 observableInitDmz=new Subject<Number>();
 observableInitIntra=new Subject<Number>();
 instanceDmzSubscription:Subscription;
 instanceIntra=[];
 instanceIntraSubscription:Subscription;
 instance=[];
 paths=[];
 filteredPaths: Observable<string[]>;
 arraySubjectOptions: Observable<string[]>;
 arraySubject=[""];
 displayedColumns= ["method", "status", "path","service",
 "operation","subject","duration","dateTime","group","server"
];
 authorization:string='';
  constructor(private trafficService:TrafficService,private formBuilder:FormBuilder,private router:Router) { }
  ngAfterViewInit() {
   // this.trafficDataSource.paginator = this.paginator;   
    //this.trafficDataSource.sort = this.sort;         
}
  ngOnInit() { 
    // this.trafficService.testCorsGateway();
     if(!this.trafficService.manageBack)
     {
        this.initForm();
     }else{
       this.searchForm=this.trafficService.searchFormBackup;
     }
    
    this.initObservables();     
    this.trafficService.getTopologyByEnv(this.searchForm.value['environnement']);    
    this.filteredPaths = this.searchForm.get('path').valueChanges
    .pipe(
      startWith(''),
      map(value => this.filterPath(value))
    );
    
    //this.trafficService.manageBack=false;
  }  
  private filterPath(value: string): string[] {
    const filterValue = value.toLowerCase();

    return this.paths.filter(option => option.toLowerCase().includes(filterValue));
  }
 initForm(){
    this.searchForm = this.formBuilder.group({    
      environnement: ['GIDN',Validators.required],
      topology: ['Tous',Validators.required],
      instance: ['Tous',Validators.required],
      timeInterval: ['10m',Validators.required],
      path: [''],
      status:[''],
      method:[''],
      transactionStatus:[''],
      duration:['gt',Validators.required],
      durationIn:[''],
      subject:[''],
      transactionId:[''],
      maxResults:['1000',Validators.required]
      
     
    });
  }
  onTest(row){
    console.log('onTest row '+JSON.stringify(row)); 
  }
  onSubmitForm(){
    
    const formValue=this.searchForm.value;
    const newSearchForm = new FormSearch(
      formValue['environnement'], formValue['topology'],formValue['instance'],formValue['timeInterval'],
      formValue['path'], formValue['status'],formValue['method'],formValue['transactionStatus'],
      formValue['duration'], formValue['durationIn'],formValue['subject'],formValue['transactionId'],formValue['maxResults']
    );  
   this.isLoading=true;
    this.trafficService.search(newSearchForm);     
  }
  onChangeValueEnvironnement(){  
   this.trafficService.getTopologyByEnv(this.searchForm.value['environnement']); 
  
  }
  onChangeValueTopology(){
  
    if(this.searchForm.value['topology']==='DMZ'){
      this.instance=this.instanceDmz;
    }else{
      if(this.searchForm.value['topology']==='INTRA'){
        this.instance=this.instanceIntra;
      }
    }
    this.searchForm.value['instance']='Tous';
   }
   onApplyFilter(filterValue: string) {
    this.trafficDataSource.filter = filterValue.trim().toLowerCase();
  } 
  onSearchByAccesToken(){
    console.log("onSearchByAccesToken "+this.authorization);
    this.trafficService.searchByHeaderAuthorization(this.authorization,this.searchForm.value['environnement']);
  }
  onStopTraffic(){
    this.trafficService.stopTraffic(this.searchForm.value['environnement']);
  }
  onStartTraffic(){
    this.trafficService.startTraffic(this.searchForm.value['environnement']);
  }
  onClickRowTraffic(traffic:any){
   
    this.trafficService.currentTraffic.traffic=traffic;
    this.trafficService.currentTraffic.env=this.searchForm.value['environnement'];
    this.trafficService.currentTraffic.instanceId=this.trafficService.getInstanceByName(traffic['server']);
    this.trafficService.searchFormBackup=this.searchForm;
    this.router.navigate(['/viewDetail']);
  }
  private initObservables() {
    forkJoin(this.observableInitDmz, this.observableInitIntra).subscribe(results => {    
      if(!this.trafficService.manageBack) {   
       this.onSubmitForm();
      }else{
        this.trafficService.emitResultSearchSubject();
        this.trafficService.manageBack=false;
       
      }
    });
    this.instanceDmzSubscription = this.trafficService.instanceDmzSubject.subscribe((dmzIns: any[]) => {
      this.instanceDmz = dmzIns;
      this.observableInitDmz.next(1);
      this.observableInitDmz.complete();
    
    });
    this.instanceIntraSubscription = this.trafficService.instanceIntraSubject.subscribe((intraIns: any[]) => {
      this.instanceIntra = intraIns;
      this.observableInitIntra.next(2);
      this.observableInitIntra.complete();
     
    });
    this.trafficDataSourceSubscription = this.trafficService.resultSearchSubject.subscribe((resultSearch: JSON) => {
      this.isLoading = false;
      this.trafficDataSource.data = resultSearch['data'];
      this.resultsLength = resultSearch['data'].length;
      //console.log('trafficDataSource  : ' + JSON.stringify(this.trafficDataSource)); 
      if(this.resultsLength){
        this.trafficDataSource.data.forEach(traffic=>{
          if(this.paths.indexOf(traffic['uri'])<0){
            this.paths.push(traffic['uri']);
          }
          if(traffic['subject'] && traffic['subject'].length!=0 && this.arraySubject.indexOf(traffic['subject'])<0){
            this.arraySubject.push(traffic['subject']);
          }
        });
        this.arraySubjectOptions=of(this.arraySubject);
      }
      this.trafficDataSource.paginator = this.paginator;
      this.trafficDataSource.sort = this.sort;      
      this.trafficDataSource.sortingDataAccessor = (item, property) => {
        //console.log(item)
        switch (property) {
          case 'fromDate': {
            return new Date(item['timestamp']*1000);
          }
          default: return item[property];
        }
      };
    });
    this.searchErrorSubscription=this.trafficService.resultErrorSubject.subscribe((result =>{
      this.isLoading=!result;
    }));
  }
}
