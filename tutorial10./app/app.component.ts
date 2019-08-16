import { Component, OnInit, OnDestroy } from '@angular/core';
import { TodoService } from './todo.service';
import { Subscription, Observable } from 'rxjs';
import { Store } from '@ngrx/store';

import * as todoAction from './store/actions/todo.actions';
import * as fromStore from './store/reducers';
import * as fromTodo from './store/selectors/todo.selectors';
import { map } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit, OnDestroy {
  data: any[];
  todosLoading$: Observable<boolean> = this.store.select(
    fromTodo.selectTodosLoading
  );
  todos$: Observable<any> = this.store.select(fromTodo.selectTodosArray);

  // todoSubscription: Subscription;

  constructor(
    private todoService: TodoService,
    private store: Store<fromStore.AppState>
  ) {}

  ngOnInit(): void {
    this.todoService
      .getTodos()
      .pipe(
        map(data => {
          console.log(data);
          return data.map(item => item.title);
        })
      )
      .subscribe(data => {
        console.log('subscribe', data);
      });

    // this.store.dispatch(new todoAction.Load());
  }

  ngOnDestroy(): void {
    // this.todoSubscription.unsubscribe();
  }
}
