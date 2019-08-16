import { Injectable } from '@angular/core';
import { Actions, Effect, ofType } from '@ngrx/effects';
import { map, mergeMap, catchError } from 'rxjs/operators';
import { TodoService } from '../../todo.service';

import * as todoAction from '../actions/todo.actions';

@Injectable()
export class TodoEffects {
  @Effect()
  loadMovies$ = this.actions$.pipe(
    ofType(todoAction.TodoActionTypes.Load),
    mergeMap(() =>
      this.todoService.getTodos().pipe(
        map(todos => new todoAction.LoadSuccess(todos)),
        catchError(error => error)
      )
    )
  );

  constructor(private actions$: Actions, private todoService: TodoService) {}
}
