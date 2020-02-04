import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ViewConnectionsComponent } from './view-connections/view-connections.component';
import {ViewKeyspaceComponent} from './view-keyspace/view-keyspace.component';
import{EditTableComponent} from './edit-table/edit-table.component';

const routes: Routes = [
  {path:'viewConnections',component:ViewConnectionsComponent},
  {path:'viewKeyspace',component:ViewKeyspaceComponent},
  {path:'editTable',component:EditTableComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
