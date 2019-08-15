import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { JklDialogComponent } from './jkl-dialog.component';

describe('JklDialogComponent', () => {
  let component: JklDialogComponent;
  let fixture: ComponentFixture<JklDialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ JklDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(JklDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
