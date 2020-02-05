import { Component, OnInit } from '@angular/core';
import {FormGroup,FormBuilder,Validators,FormArray} from '@angular/forms'; 
import {GaindeService} from '../services/gainde.service';
import {Router} from '@angular/router';
import {Subscription} from 'rxjs';

@Component({
  selector: 'app-edit-table',
  templateUrl: './edit-table.component.html',
  styleUrls: ['./edit-table.component.scss']
})
export class EditTableComponent implements OnInit {
formTable:FormGroup;
ligneColumns: FormArray;
  constructor(private gaindeService:GaindeService,private router:Router,
    private formBuilder:FormBuilder) { }

  ngOnInit() {
    this.initForm();
  }
  private initForm(){
    this.formTable = this.formBuilder.group({    
      name: ['',Validators.required],
      ligneColumns:this.formBuilder.array([ this.createLigneColumn() ])
     
    });
  }
  private createLigneColumn(): FormGroup {
    return this.formBuilder.group({
      name: '',
      type: ''      
    });
  }
  onClickAddLigneColumn() {
    this.ligneColumns = this.formTable.get('ligneColumns') as FormArray;
    this.ligneColumns.push(this.createLigneColumn());
  }
  onSubmitTable(){

  }
}
