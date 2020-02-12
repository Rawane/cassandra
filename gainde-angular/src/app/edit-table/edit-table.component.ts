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
//mapPrimaryKey=new Map<string,string>();
  constructor(private gaindeService:GaindeService,private router:Router,
    private formBuilder:FormBuilder,private snackBar:MatSnackBar,private dialog: MatDialog) { }

  ngOnInit() {
    this.allNotificationSubscription=this.gaindeService.mapTransfertViewEditTableSubject.subscribe((mapTransfert: Map<string,any>) => {
      let mapToString='';
        mapTransfert.forEach((key,item)=>{
        mapToString=mapToString+' '+item+'  value='+JSON.stringify(mapTransfert.get(item));        
      });   
     console.log('EditTableComponent mapTransfert '+mapTransfert.get("type"));  
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
    //console.log("editForm "+JSON.stringify(tableDTO));
    this.formTable = this.formBuilder.group({    
      name: [tableDTO.name,Validators.required],
      ligneColumns:this.formBuilder.array([ ])
     
    }); 
   this.ligneColumns = this.formTable.get('ligneColumns') as FormArray;   
    tableDTO.columns.forEach((columnDTO)=>{
      let indexColumn=null;
      if(tableDTO.indexColumns && tableDTO.indexColumns.length>0)
      {//console.log("editForm indexColumns "+JSON.stringify(tableDTO.indexColumns));
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
  private createLigneColumn(): FormGroup {
    return this.formBuilder.group({
      name: ['',Validators.required],
      type: ['10',Validators.required],
      primaryKey:false,
      indexed:false ,
      indexName:'',
      typeList:'',
      typeMap:'',
      oldName:''
    });
  }
  private editLigneColumn(columnDTO:ColumnDTO,indexColumn:IndexColumn): FormGroup {
      //console.log('editLigneColumn '+columnDTO.name+' type '+columnDTO.type+'  '+indexColumn);  
      let formGroup=this.formBuilder.group({
      name:[columnDTO.name,Validators.required],
      type:[columnDTO.type,Validators.required],
      primaryKey:columnDTO.primaraKey,
      indexed:{value: columnDTO.indexed, disabled:columnDTO.primaraKey},
      indexName:'',
      typeList:columnDTO.typeList,
      typeMap:columnDTO.typeMap,
      oldName:[columnDTO.name]
     });
     if(columnDTO.indexed && indexColumn){
        formGroup.get('indexName').setValue(indexColumn.name);
       // formGroup.get('indexName').setValidators([Validators.required]);
     }     

    return formGroup;
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
     controlForm.get('indexed').valueChanges.subscribe(val => {
      //console.log('onCheckIndexChange '+index+' control  '+controlForm.value['indexName']);
      if(val){
        controlForm.get('indexName').setValidators([Validators.required]);              
        if(!controlForm.value['indexName'] || controlForm.value['indexName']=='')
        {
          controlForm.get('indexName').setValue('Index_'+controlForm.value['name']);          
        } 
         
      }else{
        controlForm.get('indexName').setValue('');
        controlForm.get('indexName').setValidators([]);   
        console.log('onCheckIndexChange validator  '+controlForm.value['indexName']) ;
        this.validateIndex();   
      }
    });  
   
  } 

 /* onValueColnameChange(index:number,oldVal:any){   
    if(oldVal){
      let controlForm=this.ligneColumns.at(index);
      console.log('onValueColnameChange '+controlForm.value['name'] );
      this.mapPrimaryKey.set(controlForm.value['name'],oldVal);
    }
  }*/
  onIndexNameValueChange(index:number){    
    let controlForm=this.ligneColumns.at(index); 
    console.log('onIndexNameValueChange  '+controlForm+'  '+index) ;
    console.log('onIndexNameValueChange  '+controlForm.value['indexName']) ;
    let val=controlForm.value['indexed'] ;
    if(val){ 
      this.validateIndex();  
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
    // console.log('onValueTypeChange '+index+' controlForm  '+controlForm.value['type']);  
     let val=controlForm.value['type'];  
     
     // console.log('onValueTypeChange '+index+' control   val '+val);
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
      console.log('onSubmitTable   '+controlForm+'   value  '+controlForm.value['name']  +' oldName '+controlForm.value['oldName']);   
      let colonneDTO:ColumnDTO=new ColumnDTO();
      colonneDTO.name=controlForm.value['name'];
      colonneDTO.type=controlForm.value['type'];
      colonneDTO.oldName=controlForm.value['oldName'];      
      if(controlForm.value['primaryKey']){
           colonneDTO.primaraKey=true;
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
    console.log('onSubmitTable   '+JSON.stringify(tableDTO));  
    this.gaindeService.updateTable(this.oldTableDTO,tableDTO,this.currentGaindeEdit.connectionName,
    this.currentGaindeEdit.keyspaceName);
  }
  private openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, {
      duration: 2000,
      // here specify the position
      verticalPosition: 'top',
      panelClass: ['green-snackbar']
    });
}
onClickBack(){
  this.router.navigate(['/viewKeyspace']);
}
  private openDialog(pTitle:string,pText:string, cancelButton:boolean,pId:string): void {
    let dialogRef = this.dialog.open(DialogInfoTableComponent, {
      width: '500px',
      data: {text: pText,title:pTitle,btnCancel:cancelButton,id:pId}
    });
  
    dialogRef.afterClosed().subscribe(result => {     
      if(result!=null && result.length>1){
        console.log('afterClosed  : ' + result);
        
      }

    });
    dialogRef=null;
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