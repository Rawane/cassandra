import { Component, OnInit } from '@angular/core';
import {FormGroup,FormBuilder,Validators,FormArray} from '@angular/forms'; 
import {GaindeService} from '../services/gainde.service';
import {Router} from '@angular/router';
import {Subscription} from 'rxjs';
import {GaindeItem,TableDTO,ColumnDTO,IndexColumn} from '../model/model-dto';
@Component({
  selector: 'app-edit-table',
  templateUrl: './edit-table.component.html',
  styleUrls: ['./edit-table.component.scss']
})
export class EditTableComponent implements OnInit {
formTable:FormGroup;
ligneColumns: FormArray;
currentGaindeItem:GaindeItem;
  constructor(private gaindeService:GaindeService,private router:Router,
    private formBuilder:FormBuilder) { }

  ngOnInit() {
  this.currentGaindeItem=this.gaindeService.currentGaindeItem;
    this.initForm();    
  }
  private initForm(){
    this.formTable = this.formBuilder.group({    
      name: ['',Validators.required],
      ligneColumns:this.formBuilder.array([ this.createLigneColumn()])
     
    });
    
    this.ligneColumns = this.formTable.get('ligneColumns') as FormArray;
    if(this.currentGaindeItem)
    {
      for(let i=0;i<this.currentGaindeItem.counter-1;i++){
        this.ligneColumns.push(this.createLigneColumn());
      }
  }
  }
  private createLigneColumn(): FormGroup {
    return this.formBuilder.group({
      name: ['',Validators.required],
      type: ['10',Validators.required],
      primaryKey:'',
      indexed:'' ,
      indexName:'',
      typeList:'',
      typeMap:''
    });
  }
  onClickAddLigneColumn() {
    //this.ligneColumns = this.formTable.get('ligneColumns') as FormArray;
    this.ligneColumns.push(this.createLigneColumn());
  }
  onRemoveLineColumn(index:number){
    this.ligneColumns.removeAt(index);
  }
  onCheckIndexChange(index:number){
    let controlForm=this.ligneColumns.at(index);
    //console.log('onCheckIndexChange '+index+' controlForm  '+controlForm);    
     controlForm.get('indexed').valueChanges.subscribe(val => {
      //console.log('onCheckIndexChange '+index+' control  '+controlForm.value['indexName']);
      if(val){
        controlForm.get('indexName').setValidators([Validators.required]);
        controlForm.get('primaryKey').setValue('');
        if(!controlForm.value['indexName'] || controlForm.value['indexName']=='')
        {
           controlForm.get('indexName').setValue('Index_'+controlForm.value['name']);
          
        }        
      }else{
        controlForm.get('indexName').setValue('');
        controlForm.get('indexName').setValidators([]);
      }
    });  
  } 
  onValueTypeChange(index:number){
    let controlForm=this.ligneColumns.at(index);
     console.log('onValueTypeChange '+index+' controlForm  '+controlForm);    
     controlForm.get('type').valueChanges.subscribe(val => {
      console.log('onValueTypeChange '+index+' control   val '+val);
      if(val==='32' || val==='33'){
        controlForm.get('typeList').setValidators([Validators.required]);
              
      }else{
        controlForm.get('typeList').setValidators([]);
        if(val==='34'){
          controlForm.get('typeList').setValidators([Validators.required]);
          controlForm.get('typeMap').setValidators([Validators.required]);
        }else{
          controlForm.get('typeList').setValidators([]);
          controlForm.get('typeMap').setValidators([]);
        }
      }
    });  
  }   
  onSubmitTable(){   
    let tableDTO:TableDTO=new TableDTO(this.formTable.value['name']);   
    for (let controlForm of this.ligneColumns.controls) {
      //console.log('onSubmitTable   '+controlForm+'   value  '+controlForm.value['name']);   
      let colonneDTO:ColumnDTO=new ColumnDTO();
      colonneDTO.name=controlForm.value['name'];
      colonneDTO.type=controlForm.value['type'];
      if(controlForm.value['primaryKey']){
           colonneDTO.primaraKey=true;
      }
      if(controlForm.value['indexed']){
        colonneDTO.indexed=true;
      }      
      if(colonneDTO.type=='32' || colonneDTO.type=='33' ){
        colonneDTO.typeList=controlForm.value['typeList'];
      }
      if(colonneDTO.type=='34'){
        colonneDTO.typeList=controlForm.value['typeList'];
        colonneDTO.typeMap=controlForm.value['typeMap'];
      }
      if(colonneDTO.indexed){
        let indexColumn:IndexColumn=new IndexColumn();
        indexColumn.name=controlForm.value['indexName'];
        indexColumn.columName=controlForm.value['name'];
        tableDTO.indexColumns.push(indexColumn);
      }
      tableDTO.columns.push(colonneDTO);
    }
    console.log('onSubmitTable   '+JSON.stringify(tableDTO));  
   
  }
}
