import { Component, OnInit ,Inject} from '@angular/core';
import {FormGroup,FormBuilder,Validators,FormArray} from '@angular/forms'; 
import {GaindeService} from '../services/gainde.service';
import {Router} from '@angular/router';
import {MatDialog, MatDialogRef,MAT_DIALOG_DATA} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import {Subscription} from 'rxjs';
import {GaindeCommunication,TableDTO,ColumnDTO,IndexColumn,TypeColonnesAll,TypeColonnes,ActionHttp} from '../model/model-dto';
import{DialogData} from '../view-connections/view-connections.component';
@Component({
  selector: 'app-add-table',
  templateUrl: './add-table.component.html',
  styleUrls: ['./add-table.component.scss']
})
export class AddTableComponent implements OnInit {
allNotificationSubscription:Subscription;
formTable:FormGroup;
ligneColumns: FormArray;
currentGainde:GaindeCommunication;
optionsTypeAll=TypeColonnesAll;
optionsType=TypeColonnes;
validPrimaryKey:boolean=false;
  constructor(private gaindeService:GaindeService,private router:Router,
    private formBuilder:FormBuilder,private snackBar:MatSnackBar,private dialog: MatDialog) { }

  ngOnInit() {
    this.currentGainde=this.gaindeService.currentGainde;
    this.allNotificationSubscription=this.gaindeService.mapTransfertViewAddTableSubject.subscribe((mapTransfert: Map<string,any>) => {
      let mapToString='';
        mapTransfert.forEach((key,item)=>{
        mapToString=mapToString+' '+item+'  value='+JSON.stringify(mapTransfert.get(item));        
      }); 
   
      switch (mapTransfert.get("type") as ActionHttp)  {
            case ActionHttp.ADD_TABLE:
            { this.gaindeService.currentGainde.tableName=mapTransfert.get("content");
              this.router.navigate(['/viewKeyspace']);
                break;
            }
            case ActionHttp.ADD_TABLE_ERROR:
            {   this.openDialog('Ajout de table ',mapTransfert.get("content"),false,'');
                break;
            }            
            default:
              break;
         }
        });
      this.initForm();  
    
   
  }
  private initForm(){
    this.formTable = this.formBuilder.group({    
      name: ['',Validators.required],
      ligneColumns:this.formBuilder.array([this.createLigneColumn()])
     
    });   
    
    this.ligneColumns = this.formTable.get('ligneColumns') as FormArray;   
      if(this.currentGainde)
     {
        for(let i=0;i<this.currentGainde.counter-1;i++){
          this.ligneColumns.push(this.createLigneColumn());
        }
     }
  }
  
  private createLigneColumn(): FormGroup {
    return this.formBuilder.group({
      name: ['',Validators.required],
      type: ['10',Validators.required],
      partitionKey:false,
      clusteredColumn:false,
      indexed:false ,
      indexName:'',
      typeList:'',
      typeMap:''
    });
  }
  formControls():FormArray{

    return <FormArray>this.ligneColumns;
  }
  onClickAddLigneColumn() {
    this.ligneColumns.push(this.createLigneColumn());
  }
  onRemoveLineColumn(index:number){
    this.ligneColumns.removeAt(index);
    this.validatePrimaryKey();
  }
  onClickBack(){
    this.router.navigate(['/viewKeyspace']);
  }
  onCheckIndexChange(index:number){
    let controlForm=this.ligneColumns.at(index);
   
     controlForm.get('indexed').valueChanges.subscribe(val => {
      
      if(val){
        controlForm.get('indexName').setValidators([Validators.required]);
        if( controlForm.value['partitionKey']){
          controlForm.get('partitionKey').setValue(false);
          this.validatePrimaryKey();   
        }
        if(controlForm.value['clusteredColumn']){
          controlForm.get('clusteredColumn').setValue(false);      
        }
       
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

  onCheckPartitionKeyChange(index:number){
    let controlForm=this.ligneColumns.at(index);   
    let val=controlForm.value['partitionKey'];      
        if(val){
           controlForm.get('indexed').setValue(false); 
           controlForm.get('clusteredColumn').setValue(false);           
        }
    this.validatePrimaryKey();
  }
  onCheckClusteredColumnChange(index:number){
    let controlForm=this.ligneColumns.at(index);   
    let val=controlForm.value['clusteredColumn'];      
        if(val){
           controlForm.get('indexed').setValue(false);    
           controlForm.get('partitionKey').setValue(false);   
           this.validatePrimaryKey();      
        }
    
  }
  validatePrimaryKey():boolean{         
    for (let ctrlForm of this.ligneColumns.controls) {    
      if(ctrlForm.value['partitionKey']){   
        this.validPrimaryKey=true;     
           return true;              
      } 
    }
    this.validPrimaryKey=false;    
    return false;
  }
  onValueTypeChange(index:number){
    let controlForm=this.ligneColumns.at(index);
   
     let val=controlForm.value['type'];  
     
     
      if(val==='22' || val==='24'){
        controlForm.get('typeList').setValidators([Validators.required]);
              
      }else{
        controlForm.get('typeList').setValidators([]);
        if(val==='23'){
          controlForm.get('typeList').setValidators([Validators.required]);
          controlForm.get('typeMap').setValidators([Validators.required]);
        }else{
          controlForm.get('typeList').setValidators([]);
          controlForm.get('typeMap').setValidators([]);
        }
      }
    
  }   
  onSubmitTable(){   
    let tableDTO:TableDTO=new TableDTO(this.formTable.value['name']);   
    for (let controlForm of this.ligneColumns.controls) {
     
      let colonneDTO:ColumnDTO=new ColumnDTO();
      colonneDTO.name=controlForm.value['name'];
      colonneDTO.type=controlForm.value['type'];
      if(controlForm.value['partitionKey']){
           colonneDTO.partitionKey=true;
      }
      if(controlForm.value['clusteredColumn']){
        colonneDTO.clusteredColumn=true;
   }
      if(controlForm.value['indexed']){
        colonneDTO.indexed=true;
      }      
      if(colonneDTO.type=='22' || colonneDTO.type=='24' ){
        colonneDTO.typeList=controlForm.value['typeList'];
      }
      if(colonneDTO.type=='23'){
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
   
   this.gaindeService.saveTable(tableDTO,this.currentGainde.connectionName,
    this.currentGainde.keyspaceName);
  }
  private openDialog(pTitle:string,pText:string, cancelButton:boolean,pId:string): void {
    this.dialog.open(DialogAddInfoTableComponent, {
      width: '500px',
      data: {text: pText,title:pTitle,btnCancel:cancelButton,id:pId}
    });  
    
  }
}
@Component({
  selector: 'add-app-dialog-info-table',
  templateUrl: '../edit-table/dialog-info-table.component.html' ,
  styleUrls: ['./add-table.component.scss']
})
export class DialogAddInfoTableComponent implements OnInit {

  constructor( public dialogRef: MatDialogRef<AddTableComponent>,@Inject(MAT_DIALOG_DATA) public data: DialogData) { }

  ngOnInit() {
  }

}