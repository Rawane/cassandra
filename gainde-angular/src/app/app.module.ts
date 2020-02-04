import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {ReactiveFormsModule,FormsModule} from '@angular/forms';
import {HttpClientModule} from '@angular/common/http'
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatInputModule, MatPaginatorModule,MatSortModule, MatTableModule} from "@angular/material";
import { MatTooltipModule,MatIconModule,MatExpansionModule,MatSnackBarModule} from "@angular/material";
import {MatProgressSpinnerModule,MatCardModule,MatTreeModule,MatDialogModule } from "@angular/material";
import { MatAutocompleteModule,MatListModule,MatTabsModule,MatBadgeModule,MatStepperModule} from "@angular/material";
import { MenuComponent } from './menu/menu.component';
import { ViewConnectionsComponent,DialogInfoConnectionComponent } from './view-connections/view-connections.component';
import{GaindeService} from './services/gainde.service';
import { ViewKeyspaceComponent,DialogInfoKeyspaceComponent } from './view-keyspace/view-keyspace.component';
import { EditTableComponent } from './edit-table/edit-table.component';



@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    ViewConnectionsComponent,
    DialogInfoConnectionComponent,
    ViewKeyspaceComponent,
    DialogInfoKeyspaceComponent,
    EditTableComponent
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
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
    MatTreeModule,
    MatListModule,
    MatDialogModule,
    MatTabsModule,
    MatBadgeModule,
    MatSnackBarModule,
    MatStepperModule
  ],
  entryComponents:[DialogInfoConnectionComponent,DialogInfoKeyspaceComponent],
  providers: [GaindeService],
  bootstrap: [AppComponent]
})
export class AppModule { }
