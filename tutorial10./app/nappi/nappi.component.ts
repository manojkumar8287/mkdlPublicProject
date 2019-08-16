import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-nappi',
  templateUrl: './nappi.component.html',
  styleUrls: ['./nappi.component.css']
})
export class NappiComponent {
  @Input()
  name: string;

  @Input()
  data: any;

  @Output()
  eventti = new EventEmitter();

  onClickItem(item: number): void {
    this.eventti.emit(item);
  }
}
