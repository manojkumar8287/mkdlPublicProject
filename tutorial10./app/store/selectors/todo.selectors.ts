import { createSelector } from '@ngrx/store';
import { selectTodos } from '../reducers';
import * as fromTodos from '../reducers/todo.reducer';

export const selectTodosLoading = createSelector(
  selectTodos,
  (state: fromTodos.State) => state.loading
);

export const selectTodosArray = createSelector(
  selectTodos,
  (state: fromTodos.State) => {
    return state.todos;
  }
);
