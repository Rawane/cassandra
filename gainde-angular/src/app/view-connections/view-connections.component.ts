import { Component, OnInit,Inject } from '@angular/core';
import {FormGroup,FormBuilder,Validators} from '@angular/forms'; 
import {Router} from '@angular/router';
import {Subscription} from 'rxjs';
import {GaindeService} from '../services/gainde.service';
import {ConnectionDTO,ActionHttp,GaindeCommunication} from '../model/model-dto';
import {MatDialog, MatDialogRef,MAT_DIALOG_DATA} from '@angular/material/dialog';
import {MatSnackBar} from '@angular/material/snack-bar';


export interface DialogData {
  text: string;
  title:string;
  btnCancel:boolean;
  id:string;
  
}

@Component({
  selector: 'app-view-connections',
  templateUrl: './view-connections.component.html',
  styleUrls: ['./view-connections.component.scss']
})
export class ViewConnectionsComponent implements OnInit {
  connectionForm:FormGroup; 
  connections:any;
  //metaConnection:any;
  allNotificationSubscription:Subscription;
  saveOrUpdate:boolean=true;
  saveConnection:boolean;
  deleteConnection:boolean;
  currentConnection:ConnectionDTO;
  constructor(private gaindeService:GaindeService,
    private formBuilder:FormBuilder,private dialog: MatDialog,private router:Router,private snackBar:MatSnackBar) { 

  }
  ngOnInit() {
    //init Obersver
    //this.gaindeService.testCSPGateway();
    this.allNotificationSubscription=this.gaindeService.mapTransfertViewConnectionSubject.subscribe((mapTransfert: Map<string,any>) => {
      let mapToString='';
      mapTransfert.forEach((key,item)=>{
        mapToString=mapToString+' '+item+'  value='+JSON.stringify(mapTransfert.get(item));        
      });   
      console.log('ViewConnectionsComponent mapTransfert '+mapTransfert.get("type"));     
       switch (mapTransfert.get("type") as ActionHttp) {
         case ActionHttp.ALL_CONNECTION:
           this.connections=mapTransfert.get("content");           
           break;
          case ActionHttp.SAVE_CONNECTION:
            this.doAfterSaveConnectionOk(mapTransfert);           
            break;
          case ActionHttp.SAVE_CONNECTION_ERROR:
            this.openDialog('Info connection',"Erreur de sauvegarde",false,'');
            break;
          case ActionHttp.UPDATE_CONNECTION:
              this.openSnackBar('La connection '+mapTransfert.get("content")['name']+' a été mis à jour avec succés','');
              this.gaindeService.getAllConnections();           
              break;
          case ActionHttp.UPDATE_CONNECTION_ERROR:
              this.openDialog('Info connection',"Erreur de mis à jour",false,'');
              break;
          case ActionHttp.DELETE_CONNECTION:
            this.openSnackBar('La connection '+mapTransfert.get("content")+' a été supprimée avec succés','');
            this.gaindeService.getAllConnections();
            break;
          case ActionHttp.DELETE_CONNECTION_ERROR:
            this.openDialog('Info connection',"Erreur de suppression",false,'');
            break;
          case ActionHttp.CONNECT_TO:
            this.gaindeService.currentGainde.content=mapTransfert.get("content");
            this.router.navigate(['/viewKeyspace']);
            break;
          case ActionHttp.CONNECT_TO_ERROR:
            let msg:string=mapTransfert.get("content");
            this.openDialog('Erreur de Connection',msg,false,'');
            break;    
         default:          
           break;
       }
      
    }); 
   
    this.gaindeService.getAllConnections();
    this.initForm();
  }
  private doAfterSaveConnectionOk(mapTransfert: Map<string, any>) {
    this.openSnackBar('La connection ' + mapTransfert.get("content")['name'] + ' a été ajoutée avec succés', '');
    this.saveOrUpdate = true;
    this.resetForm();
    this.gaindeService.getAllConnections();
  }

  openSnackBar(message: string, action: string) {
    this.snackBar.open(message, action, {
      duration: 2000,
      // here specify the position
      verticalPosition: 'top',
      panelClass: ['green-snackbar']
    });
}
private resetForm(){
    this.connectionForm.get('name').setValue('');
    this.connectionForm.get('ip').setValue('');
    this.connectionForm.get('port').setValue('');
    this.connectionForm.get('username').setValue('');
    this.connectionForm.get('password').setValue('');
}
  onClickShowInfoConnection(conn:JSON){
    //console.log('onShowInfoConnection  : ' + JSON.stringify(conn));
    this.connectionForm.get('name').setValue(conn['name']);
    this.connectionForm.get('ip').setValue(conn['ip']);
    this.connectionForm.get('port').setValue(conn['port']);
    this.connectionForm.get('username').setValue(conn['username']);
    this.connectionForm.get('password').setValue(conn['password']);
    this.saveOrUpdate=false;
    this.currentConnection=new ConnectionDTO(conn['name'],conn['ip'],
    conn['port'], conn['username'],conn['password']); 
    this.connectionForm.get('name').disable();
  }
  onClickNewConnection(){   
    this.connectionForm.get('name').setValue('');
    this.connectionForm.get('ip').setValue('');
    this.connectionForm.get('port').setValue('');
    this.connectionForm.get('username').setValue('');
    this.connectionForm.get('password').setValue('');
    this.saveOrUpdate=true;
    this.connectionForm.get('name').enable();
  }
  onClickCopyConnection(conn:JSON){   
    this.connectionForm.get('name').setValue('Copy de '+conn['name']);
    this.connectionForm.get('ip').setValue(conn['ip']);
    this.connectionForm.get('port').setValue(conn['port']);
    this.connectionForm.get('username').setValue(conn['username']);
    this.connectionForm.get('password').setValue(conn['password']);
    this.saveOrUpdate=true;
    this.connectionForm.get('name').enable();
  }
  onClickConnectToCassandra(conn:JSON){
    //console.log('onConnectToCassandra  : ' + JSON.stringify(conn));   
    this.connectionForm.get('name').setValue(conn['name']);
    this.connectionForm.get('ip').setValue(conn['ip']);
    this.connectionForm.get('port').setValue(conn['port']);
    this.connectionForm.get('username').setValue(conn['username']);
    this.connectionForm.get('password').setValue(conn['password']);
    this.saveOrUpdate=false;

  }
  onDblClickConnectToCassandra(conn:JSON){
    //console.log('onConnectToCassandra  : ' + JSON.stringify(conn));
    let  connectDTO=new ConnectionDTO(conn['name'],conn['ip'],
    conn['port'], conn['username'],conn['password']); 
    this.gaindeService.currentGainde=new GaindeCommunication(); 
    this.gaindeService.currentGainde.connection=connectDTO;
    this.gaindeService.connecToCassandra(connectDTO);

  }
  onSubmitFormConnection(actionButton){   
    //console.log('onConnectToCassandra  : ' + this.connectionForm.value['name']+'   actionButton '+actionButton); 
    
    let  connectDTO=new ConnectionDTO(this.connectionForm.value['name'],this.connectionForm.value['ip'],
    this.connectionForm.value['port'], this.connectionForm.value['username'],this.connectionForm.value['password']); 
    if(this.connectionForm.get('name').disabled){
      connectDTO.name=this.currentConnection.name;
    } 
    if('save'===actionButton){       
        if(this.saveOrUpdate){
          this.gaindeService.saveConnection(connectDTO);       
        }else{
          this.gaindeService.updateConnection(connectDTO);
        }
    }
    else {    
          this.gaindeService.currentGainde=new GaindeCommunication();       
          this.gaindeService.currentGainde.connection=connectDTO;
          this.gaindeService.connecToCassandra(connectDTO);
    }
  }
  onClickRemoveConnection(name:string){
    this.openDialog('Confirmation de suppression',"Voulez-vous supprimer la connection?"+name,true,name);
  }
  private initForm(){
    this.connectionForm = this.formBuilder.group({    
      name: ['',Validators.required],
      ip: ['',Validators.required],
      port: ['',Validators.required],
      username:[''],
      password:['']
     
    });
  }
  openDialog(pTitle:string,pText:string, cancelButton:boolean,pId:string): void {
    const dialogRef = this.dialog.open(DialogInfoConnectionComponent, {
      width: '500px',
      data: {text: pText,title:pTitle,btnCancel:cancelButton,id:pId}
    });

    dialogRef.afterClosed().subscribe(result => {     
      if(result!=null && result.length>1){
        this.gaindeService.deleteConnection(result);
      }

    });
  }
}


@Component({
  selector: 'app-dialog-info-connection',
  templateUrl: './dialog-info-connection.component.html' ,
  styleUrls: ['./view-connections.component.scss']
})
export class DialogInfoConnectionComponent implements OnInit {

  constructor( public dialogRef: MatDialogRef<ViewConnectionsComponent>,@Inject(MAT_DIALOG_DATA) public data: DialogData) { }

  ngOnInit() {
  }

}
