import { Component, OnInit, Inject, Input } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { DialogData } from '../jkl-summary/jkl-summary.component';

@Component({
  selector: 'app-jkl-dialog',
  templateUrl: './jkl-dialog.component.html',
  styleUrls: ['./jkl-dialog.component.css']
})
export class JklDialogComponent implements OnInit {

  @Input()
  details : any[];

  ngOnInit() {  }


  constructor(
    public dialogRef: MatDialogRef<JklDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData) {
      console.log(data.category.detail);
     // this.details = this.data.category.detail.split("\n");
    }

  onNoClick(): void {
    this.dialogRef.close();
  }

}




