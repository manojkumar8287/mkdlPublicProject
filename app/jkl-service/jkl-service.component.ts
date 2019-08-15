import { Component, OnInit  } from '@angular/core';
import { Observable } from 'rxjs';
import { AngularFirestore } from '@angular/fire/firestore';


@Component({
  selector: 'app-jkl-service',
  templateUrl: './jkl-service.component.html',
  styleUrls: ['./jkl-service.component.css'],

})
export class JklServiceComponent implements OnInit {
  services: Observable<any[]>;
  categories: Observable<any[]>;
  db : AngularFirestore;
  constructor(db: AngularFirestore) {
    //this.services = db.collection('services').valueChanges();
    this.services =db.collection('services',ref => {
      let query : firebase.firestore.CollectionReference | firebase.firestore.Query = ref;
      query = query.where('isReviewed', '==',true);
      query = query.orderBy("order");

      return query;
    }).valueChanges();
    this.db = db;
  }

  ngOnInit() {
  }

  /*onClick(service: String):void{
    // Create a query against the collection.

    this.categories =this.db.collection('categories',ref => {
      let query : firebase.firestore.CollectionReference | firebase.firestore.Query = ref;
      query = query.where('service', '==',service) ;

      return query;
    }).valueChanges();



  }*/

}
