import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import {ViewTrafficComponent} from './view-traffic/view-traffic.component'
import {TestComponent} from './test/test.component';
import {DetailTrafficComponent} from './detail-traffic/detail-traffic.component';
const routes: Routes = [
  {path:'view-traffic',component:ViewTrafficComponent},
  {path:'test',component:TestComponent},
  {path:'viewDetail',component:DetailTrafficComponent}

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
