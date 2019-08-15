import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { JklServiceComponent } from './jkl-service.component';

describe('JklServiceComponent', () => {
  let component: JklServiceComponent;
  let fixture: ComponentFixture<JklServiceComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ JklServiceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(JklServiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
