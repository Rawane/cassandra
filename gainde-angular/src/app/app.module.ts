import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {ReactiveFormsModule,FormsModule} from '@angular/forms';
import {HttpClientModule} from '@angular/common/http'
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {platformBrowserDynamic} from '@angular/platform-browser-dynamic';
import { MatInputModule, MatPaginatorModule,MatSortModule, MatTableModule,MatDatepickerModule,MatDateFormats,MAT_DATE_LOCALE,MAT_DATE_FORMATS,} from "@angular/material";
import { MatTooltipModule,MatIconModule,MatExpansionModule,MatSnackBarModule,MatNativeDateModule} from "@angular/material";
import {MatProgressSpinnerModule,MatCardModule,MatTreeModule,MatDialogModule } from "@angular/material";
import {DragDropModule} from '@angular/cdk/drag-drop';
import { MatAutocompleteModule,MatListModule,MatTabsModule,MatBadgeModule,MatStepperModule} from "@angular/material";
import { MenuComponent } from './menu/menu.component';
import { ViewConnectionsComponent,DialogInfoConnectionComponent } from './view-connections/view-connections.component';

import{ GaindeService} from './services/gainde.service';
import { ViewKeyspaceComponent,DialogInfoKeyspaceComponent ,DialogTableColumnInfoComponent,DialogEditRowComponent,DialogSelectColumnComponent,DialogViewCellComponent,DialogImportKeyspaceComponent} from './view-keyspace/view-keyspace.component';
import { EditTableComponent ,DialogInfoTableComponent} from './edit-table/edit-table.component';
import { AutofocusDirective } from './directive/autofocus.directive';
import { AddTableComponent,DialogAddInfoTableComponent } from './add-table/add-table.component';

export const FORMAT_GAINDE: MatDateFormats = {
  parse: {
  dateInput: 'DD/MM/YYYY',
  },
  display: {
  dateInput: 'DD/MM/YYYY',
  monthYearLabel: 'MMM YYYY',
  dateA11yLabel: 'DD/MM/YYYY',
  monthYearA11yLabel: 'MMMM YYYY',
  },
  };

@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    ViewConnectionsComponent,
    DialogInfoConnectionComponent,
    ViewKeyspaceComponent,
    DialogInfoKeyspaceComponent,
    DialogInfoTableComponent,
    DialogTableColumnInfoComponent,
    DialogEditRowComponent,
    DialogSelectColumnComponent,
    EditTableComponent,
    AutofocusDirective,
    AddTableComponent,
    DialogAddInfoTableComponent,
    DialogViewCellComponent,
    DialogImportKeyspaceComponent
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
    MatStepperModule,
    MatDatepickerModule,
    MatNativeDateModule,
    DragDropModule
  ],
  entryComponents:[
  DialogInfoConnectionComponent,
  DialogInfoKeyspaceComponent,
  DialogTableColumnInfoComponent,
  DialogInfoTableComponent,
  DialogAddInfoTableComponent,
  DialogEditRowComponent,
  DialogSelectColumnComponent,
  DialogViewCellComponent,
  DialogImportKeyspaceComponent
  ],
  providers: [GaindeService,
    { provide: MAT_DATE_LOCALE, useValue: 'fr-FR' },
    { provide: MAT_DATE_FORMATS, useValue: FORMAT_GAINDE }
    ],
  bootstrap: [AppComponent]
})
export class AppModule {
  
 }
 platformBrowserDynamic().bootstrapModule(AppModule)
 .catch(err => console.error(err));