import { Component, OnInit } from '@angular/core';
import {FormGroup,FormBuilder,Validators} from '@angular/forms'; 
import {Router} from '@angular/router';
import {Subscription} from 'rxjs';
import {NestedTreeControl} from '@angular/cdk/tree';
import {MatTreeNestedDataSource} from '@angular/material/tree';
import {MatTableDataSource} from '@angular/material/table';
import {GaindeService} from '../services/gainde.service';
import {ConnectionDTO} from '../model/connection-dto';
import {KeyspaceDTO} from '../model/keyspace-dto';
interface Meta {
  name:string; 
  metas:Meta[];
}
@Component({
  selector: 'app-view-keyspace',
  templateUrl: './view-keyspace.component.html',
  styleUrls: ['./view-keyspace.component.scss']
})
export class ViewKeyspaceComponent implements OnInit {
  treeControl = new NestedTreeControl<Meta>(node => node.metas);
  dataSource = new MatTreeNestedDataSource<Meta>();
  homeKeyspaceVisible:boolean=false;
  tabsTableVisible:boolean=false;
  createKeyspaceVisible:boolean=false;
  connectionClosedSubscription:Subscription;
  tableInfoSubscription:Subscription;
  errorClosedSubscription:Subscription;
  tableColumnsSubscription:Subscription;
  tableInfo:JSON;
  displayedColumns=['name','type','primaraKey','indexed'];
  displayedColumnsPrimary=['key'];
  displayedColumnsIndex=['name','indexName'];
  colonneDataSource=new MatTableDataSource<JSON>();
  currentTableKeys:string[];
  selectedPageIndex=0;
  currentNodeId:string='';
  currentConnection:ConnectionDTO;
  columnsSize:number;
  keyspaceForm:FormGroup; 
  hasChild = (_: number, node: Meta) => !!node.metas && node.metas.length > 0;
  constructor(private gaindeService:GaindeService,private router:Router,private formBuilder:FormBuilder) { }

  ngOnInit() {
    this.currentConnection=this.gaindeService.currentConnection;
    if(this.gaindeService.currentMetaConnection){
      this.dataSource.data=this.gaindeService.currentMetaConnection;
      this.homeKeyspaceVisible=true;    
    }
    this.connectionClosedSubscription=this.gaindeService.connectionClosedSubject.subscribe((result: boolean) => {     
      if(result){
        this.router.navigate(['/viewConnections']);
      }
    });
    this.errorClosedSubscription=this.gaindeService.errorConnectionCloseSubject.subscribe((result: string) => {    
     
    });
    this.tableInfoSubscription=this.gaindeService.tableInfoSubject.subscribe((result: JSON) => {    
     this.tableInfo=result;
     this.colonneDataSource.data=this.tableInfo['columns']; 
     this.columnsSize=this.tableInfo['columns'].length;   
     this.tabsTableVisible=true;

    });    
     
  }
  private initForm(){
    this.keyspaceForm = this.formBuilder.group({    
      name: ['',Validators.required],
      strategy: ['',Validators.required],
      replication: ['',Validators.required],
      durableWrite:[true]
     
    });
  }
  onClickCloseConnection(){
    if(this.gaindeService.currentConnection){
      let name:string=this.gaindeService.currentConnection['name'];
      this.gaindeService.closeConnection(name);
    }
  }
  onClickRowNode(node){
    //console.log('onClickRowNode  : ' + JSON.stringify(node));
    if(node['type']===1){
      this.tabsTableVisible=false;
    }else{
      this.currentNodeId=node['id'];   
      this.currentTableKeys=node['id'].split("#");
      this.gaindeService.getInfoTable(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      if(this.selectedPageIndex==1) 
      {
        this.selectedPageIndex=0;
      }
    }
  }
  onClickAddKeyspace(){
    this.tabsTableVisible=false;
    this.initForm();
    this.createKeyspaceVisible=true;
  }
  onClickSaveKeyspace(){
    let  keyspaceDTO=new KeyspaceDTO(this.keyspaceForm.value['name'],this.keyspaceForm.value['strategy'],
    this.keyspaceForm.value['replication'], this.keyspaceForm.value['durableWrite']);    
    this.gaindeService.saveKeyspace(keyspaceDTO);
  }
  onClickShowTabColonne(){
      console.log('onClickShowTabColonne  : ' + JSON.stringify(this.currentTableKeys));  
      console.log('onClickShowTabColonne event : ' + this.selectedPageIndex);  
      if(this.currentTableKeys && this.selectedPageIndex==1){
        this.gaindeService.getAllDatas(this.currentTableKeys[0],this.currentTableKeys[1],this.currentTableKeys[2]);   
      }        
   
  }
}
