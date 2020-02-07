import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {ReactiveFormsModule,FormsModule} from '@angular/forms';
import {HttpClientModule} from '@angular/common/http'
import {TrafficService} from './services/traffic.service';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ViewTrafficComponent } from './view-traffic/view-traffic.component';
import { TrafficComponent } from './traffic/traffic.component';
import { MenuComponent } from './menu/menu.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatInputModule, MatPaginatorModule,MatSortModule, MatTableModule,MatAutocompleteModule } from "@angular/material";
import { MatTooltipModule,MatIconModule,MatExpansionModule,MatProgressSpinnerModule,MatCardModule,MatTreeModule } from "@angular/material";
import { TestComponent } from './test/test.component';
import { DetailTrafficComponent } from './detail-traffic/detail-traffic.component';
@NgModule({
  declarations: [
    AppComponent,
    ViewTrafficComponent,
    TrafficComponent,
    MenuComponent,
    TestComponent,
    DetailTrafficComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatInputModule,
    MatTableModule,
    MatPaginatorModule,
    MatSortModule,
    MatAutocompleteModule,
    MatTooltipModule,
    MatIconModule,
    MatExpansionModule,
    MatProgressSpinnerModule,
    MatCardModule,
    MatTreeModule
        
  ],
  providers: [TrafficService],
  bootstrap: [AppComponent]
})
export class AppModule { }
