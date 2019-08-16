import { createSelector } from '@ngrx/store';
import * as fromTodos from './todo.reducer';

export interface AppState {
  todos: fromTodos.State;
}

export const selectTodos = (state: AppState) => state.todos;
