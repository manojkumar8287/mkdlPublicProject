import { Component, OnInit, Input, Inject } from '@angular/core';
import { Subscriber, Observable } from 'rxjs';
import { AngularFirestore } from '@angular/fire/firestore';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material';
import { JklDialogComponent } from '../jkl-dialog/jkl-dialog.component';

@Component({
  selector: 'app-jkl-summary',
  templateUrl: './jkl-summary.component.html',
  styleUrls: ['./jkl-summary.component.css']
})
export class JklSummaryComponent implements OnInit {
  @Input()
  categories: Observable<any[]>;

  @Input()
  services: any[];

  @Input()
  showIt:boolean = false;

  db : AngularFirestore;

  constructor(db: AngularFirestore, public dialog: MatDialog) {

    this.db = db;
  }

  ngOnInit() {

  }

  openService(name:String) :void{
    console.log("name ", name);
    if(name==="What's new"){
      this.categories =this.db.collection('updates',ref => {
        let query : firebase.firestore.CollectionReference | firebase.firestore.Query = ref;
       // query = query.where('service', '==',name);
        query = query.where('isReviewed', '==',true);
        query = query.orderBy("day");

        return query;
      }).valueChanges();
    }else{
      this.categories =this.db.collection('categories',ref => {
        let query : firebase.firestore.CollectionReference | firebase.firestore.Query = ref;
        query = query.where('service', '==',name);
        query = query.where('isReviewed', '==',true);
        query = query.orderBy("order");

        return query;
      }).valueChanges();
    }

  }

  explore(category: any):void {
      this.showIt = true;
      console.log(category.name);
      const dialogRef = this.dialog.open(JklDialogComponent, {
        width: '70%',
        data:{category :category}
      });

      dialogRef.afterClosed().subscribe(result => {
        console.log('The dialog was closed');

      });


  }

}


export interface DialogData {
  category: any;
}



