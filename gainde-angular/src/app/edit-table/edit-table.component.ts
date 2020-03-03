import { Component, OnInit ,Inject,OnDestroy} from '@angular/core';
import {FormGroup,FormBuilder,Validators,FormArray} from '@angular/forms'; 
import {GaindeService} from '../services/gainde.service';
import {Router} from '@angular/router';
import {MatDialog, MatDialogRef,MAT_DIALOG_DATA} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';
import {Subscription} from 'rxjs';
import {GaindeCommunication,TableDTO,ColumnDTO,IndexColumn,TypeColonnesAll,TypeColonnes,ActionHttp} from '../model/model-dto';
import{DialogData} from '../view-connections/view-connections.component';
@Component({
  selector: 'app-edit-table',
  templateUrl: './edit-table.component.html',
  styleUrls: ['./edit-table.component.scss']
})
export class EditTableComponent implements OnInit,OnDestroy {
allNotificationSubscription:Subscription;
formTable:FormGroup;
ligneColumns: FormArray;
currentGaindeEdit:GaindeCommunication;
optionsTypeAll=TypeColonnesAll;
optionsType=TypeColonnes;
oldTableDTO:TableDTO;
validIndex:boolean=true;
validDuplicateName:boolean=true;
  constructor(private gaindeService:GaindeService,private router:Router,
    private formBuilder:FormBuilder,private snackBar:MatSnackBar,private dialog: MatDialog) {

     }

  ngOnInit() {
    this.allNotificationSubscription=this.gaindeService.mapTransfertViewEditTableSubject.subscribe((mapTransfert: Map<string,any>) => {
      let mapToString='';
        mapTransfert.forEach((key,item)=>{
        mapToString=mapToString+' '+item+'  value='+JSON.stringify(mapTransfert.get(item));        
      }); 
    
      switch (mapTransfert.get("type") as ActionHttp)  {
            case ActionHttp.UPDATE_TABLE:
            { this.gaindeService.currentGainde.tableName=mapTransfert.get("content");
              this.router.navigate(['/viewKeyspace']);
                break;
            }
            case ActionHttp.UPDATE_TABLE_ERROR:
            {   this.openDialog('Mis à jour de table ',mapTransfert.get("content"),false,'');
                break;
            }
            case ActionHttp.EDIT_TABLE:
              {  this.oldTableDTO=mapTransfert.get("content");
                if(this.oldTableDTO){
                  this.editForm();                  
                }
                break;
              }
            default:
              break;
         }
        });
    this.currentGaindeEdit=this.gaindeService.currentGainde;
    let tableName=this.currentGaindeEdit.tableName;
    if(tableName){
     this.gaindeService.getInfoTableEdit(this.currentGaindeEdit.connectionName,this.currentGaindeEdit.keyspaceName,tableName);
    }   
  }
  ngOnDestroy() {
    this.allNotificationSubscription.unsubscribe();
  }
  private editForm(){
    let tableDTO=this.oldTableDTO;
   
    this.formTable = this.formBuilder.group({    
      name: [tableDTO.name,Validators.required],
      ligneColumns:this.formBuilder.array([])
     
    }); 
    this.ligneColumns = this.formTable.get('ligneColumns') as FormArray;   
    tableDTO.columns.forEach((columnDTO)=>{
      let indexColumn=null;
      if(tableDTO.indexColumns && tableDTO.indexColumns.length>0)
      {
        for(let indexCol of tableDTO.indexColumns )
        {   if(indexCol.columName==columnDTO.name)
            {
              indexColumn=indexCol;
             break;
          }
        }
      }
      let formGroupEdit=this.editLigneColumn(columnDTO,indexColumn);
      this.ligneColumns.push(formGroupEdit);
    });
      
  }

  formControls():FormArray{

    return <FormArray>this.ligneColumns;
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
      typeMap:'',
      oldName:''
    });
  }
  private editLigneColumn(columnDTO:ColumnDTO,indexColumn:IndexColumn): FormGroup {
    
      let formGroup=this.formBuilder.group({
      name:[columnDTO.name,Validators.required],
      type:[columnDTO.type,Validators.required],
      partitionKey:columnDTO.partitionKey,
      clusteredColumn:columnDTO.clusteredColumn,
      indexed:{value: columnDTO.indexed, disabled:columnDTO.partitionKey},
      indexName:'',
      typeList:columnDTO.typeList,
      typeMap:columnDTO.typeMap,
      oldName:[columnDTO.name]
     });
     if(columnDTO.indexed && indexColumn){
       if( formGroup.get('indexName')){
        formGroup.get('indexName').setValue(indexColumn.name);
       }
      
     }     

    return formGroup;
  }
  onClickAddLigneColumn() {
   
    this.ligneColumns.push(this.createLigneColumn());
  }
  onRemoveLineColumn(index:number){
    this.ligneColumns.removeAt(index);
  }

  onCheckIndexChange(index:number){
    let controlForm=this.ligneColumns.at(index);   
     controlForm.get('indexed').valueChanges.subscribe(val => {
     
      if(val){
        controlForm.get('indexName').setValidators([Validators.required]);              
        if(!controlForm.value['indexName'] || controlForm.value['indexName']=='')
        {
          controlForm.get('indexName').setValue('Index_'+controlForm.value['name']);          
        } 
         
      }else{
        controlForm.get('indexName').setValue('');
        controlForm.get('indexName').setValidators([]);   
      
        this.validateIndex();   
      }
    });  
   
  } 

 
  onIndexNameValueChange(index:number){    
    let controlForm=this.ligneColumns.at(index); 
   
    let val=controlForm.value['indexed'] ;
    if(val){ 
      this.validateIndex();  
    }
   
  } 
  
  onValueNameChange(index:number){   
   let count:number=0;   
  
   let controlForm=this.ligneColumns.at(index);   
      for (let ctrlFormAutre of this.ligneColumns.controls) {    
       if(controlForm.value['name']==ctrlFormAutre.value['name']){
         count++;
       }
      }
     
    if(count>1){
      this.validDuplicateName=false;
    }else{
      count=0;
    for (let controlF of this.ligneColumns.controls) 
    {
      for (let ctrlFormA of this.ligneColumns.controls) {    
        if(controlF.value['name']==ctrlFormA.value['name']){
          count++;
        }
       }
      }
     
      if(count==this.ligneColumns.controls.length){
        this.validDuplicateName=true; 
      }else{
        this.validDuplicateName=false;
      }
    }
    
  }
  validateIndex():boolean{         
    for (let ctrlForm of this.ligneColumns.controls) {    
      if(ctrlForm.value['indexed'] && (!ctrlForm.value['indexName'] || ctrlForm.value['indexName']=='')){   
        this.validIndex=false;     
           return false;              
      } 
    }
    this.validIndex=true;    
    return true;
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
      colonneDTO.oldName=controlForm.value['oldName'];      
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
   
    this.gaindeService.updateTable(this.oldTableDTO,tableDTO,this.currentGaindeEdit.connectionName,
    this.currentGaindeEdit.keyspaceName);
  }
  
onClickBack(){
  this.router.navigate(['/viewKeyspace']);
}
  private openDialog(pTitle:string,pText:string, cancelButton:boolean,pId:string): void {
   this.dialog.open(DialogInfoTableComponent, {
      width: '500px',
      data: {text: pText,title:pTitle,btnCancel:cancelButton,id:pId}
    });  
   
   
  }
}
@Component({
  selector: 'app-dialog-info-table',
  templateUrl: './dialog-info-table.component.html' ,
  styleUrls: ['./edit-table.component.scss']
})
export class DialogInfoTableComponent implements OnInit {

  constructor( public dialogRef: MatDialogRef<EditTableComponent>,@Inject(MAT_DIALOG_DATA) public data: DialogData) { }

  ngOnInit() {
  }

}