import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { JklServiceComponent } from './jkl-service/jkl-service.component';
import { AngularFireModule } from '@angular/fire';
import { AngularFirestoreModule } from '@angular/fire/firestore';
import { environment } from '../environments/environment';

import { NoopAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from 'src/material.module';
import { JklSummaryComponent } from './jkl-summary/jkl-summary.component';
import { JklDialogComponent } from './jkl-dialog/jkl-dialog.component';


@NgModule({
  declarations: [
    AppComponent,
    JklServiceComponent,
    JklSummaryComponent,
    JklDialogComponent
  ],
  entryComponents: [JklDialogComponent],
  imports: [
    BrowserModule,
    AngularFireModule.initializeApp(environment.firebase),
    AngularFirestoreModule,
    AppRoutingModule,
    NoopAnimationsModule,
    MaterialModule
  ],
  providers: [],
  bootstrap: [AppComponent, JklServiceComponent]
})
export class AppModule { }
