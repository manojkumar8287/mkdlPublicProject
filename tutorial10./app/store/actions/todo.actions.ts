import { Action } from '@ngrx/store';

export enum TodoActionTypes {
  Load = '[Todos] Load',
  LoadSuccess = '[Todos] Load Success'
}

export class Load implements Action {
  readonly type = TodoActionTypes.Load;
}

export class LoadSuccess implements Action {
  readonly type = TodoActionTypes.LoadSuccess;
  constructor(public payload: any[]) {}
}

export type TodoActionUnion = Load | LoadSuccess;
