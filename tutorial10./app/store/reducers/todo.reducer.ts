import * as Todo from '../actions/todo.actions';

export interface State {
  todos: any[];
  loading: boolean;
}

export const initialState: State = {
  todos: [],
  loading: false
};

export function reducer(
  state = initialState,
  action: Todo.TodoActionUnion
): State {
  switch (action.type) {
    case Todo.TodoActionTypes.Load: {
      return {
        ...state,
        loading: true
      };
    }

    case Todo.TodoActionTypes.LoadSuccess: {
      return {
        ...state,
        loading: false,
        todos: action.payload
      };
    }

    default: {
      return state;
    }
  }
}
