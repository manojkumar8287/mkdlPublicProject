import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { JklSummaryComponent } from './jkl-summary.component';

describe('JklSummaryComponent', () => {
  let component: JklSummaryComponent;
  let fixture: ComponentFixture<JklSummaryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ JklSummaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(JklSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
