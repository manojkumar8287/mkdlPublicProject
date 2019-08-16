import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpClientModule } from '@angular/common/http';

import { AppComponent } from './app.component';
import { NappiComponent } from './nappi/nappi.component';
import { StoreModule } from '@ngrx/store';
import { reducer } from './store/reducers/todo.reducer';

import { StoreDevtoolsModule } from '@ngrx/store-devtools';
import { EffectsModule } from '@ngrx/effects';
import { TodoEffects } from './store/effects/todo.effect';

@NgModule({
  declarations: [AppComponent, NappiComponent],
  imports: [
    BrowserModule,
    HttpClientModule,
    StoreModule.forRoot({ todos: reducer }),
    EffectsModule.forRoot([TodoEffects]),
    StoreDevtoolsModule.instrument()
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {}
