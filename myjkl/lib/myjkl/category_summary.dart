import 'package:flutter/material.dart';
import 'package:myjkl/model/category_model.dart';
import 'package:myjkl/model/service_model.dart';
import 'package:myjkl/myjkl/category_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategorySummary {
  Widget getContainerList(BuildContext context, List<CategoryModel> categories,
      ServiceModel service) {
    return Container(
      child: Column(
          children: List.generate(
        categories.length,
        (index) {
          return Card(
              color: Colors.white12,
              elevation: 3.0,
              child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.white),
                  child: Container(
                      width: 1000,
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              width: 1000,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.blue),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 8.0),
                                child: Text(
                                    categories.elementAt(index).getName(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                            onTap: () {
                              openDetails(context, categories, index, service);
                            },
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 8.0),
                              child: Text(
                                  categories
                                      .elementAt(index)
                                      .getSummary()
                                      .replaceAll("\\n", "\n"),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  softWrap: true),
                            ),
                            onTap: () {
                              openDetails(context, categories, index, service);
                            },
                          ),
                          categories.elementAt(index).getHotline().isNotEmpty
                              ? Container(
                                  width: 1000,
                                  child: InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.0, vertical: 5.0),
                                      child: Text(
                                        categories
                                                .elementAt(index)
                                                .getHotline()
                                                .split('<NUM>')[0] +
                                            "- " +
                                            categories
                                                .elementAt(index)
                                                .getHotline()
                                                .split('<NUM>')[1],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.blue),
                                      ),
                                    ),
                                    onTap: () {
                                      _launchCALL(categories
                                          .elementAt(index)
                                          .getHotline()
                                          .split('<NUM>')[1]
                                          .trim());
                                    },
                                  ),
                                )
                              : Text(""),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                          ),
                          categories
                                  .elementAt(index)
                                  .getLink()
                                  .trim()
                                  .isNotEmpty
                              ? Container(
                                  width: 1000,
                                  child: InkWell(
                                    child: Text(
                                      " find more on web",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.blue),
                                    ),
                                    onTap: () {
                                      String name =
                                          categories.elementAt(index).getLink();
                                      _launchURL(name.trim());
                                    },
                                  ),
                                )
                              : Text(""),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.remove_red_eye),
                                    Text(
                                      " " +
                                          categories
                                              .elementAt(index)
                                              .views
                                              .toString(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                    ),
                                    Text(
                                      "Last updated- " +
                                          categories
                                              .elementAt(index)
                                              .getUpdated()
                                              .day
                                              .toString() +
                                          "." +
                                          categories
                                              .elementAt(index)
                                              .getUpdated()
                                              .month
                                              .toString() +
                                          "." +
                                          categories
                                              .elementAt(index)
                                              .getUpdated()
                                              .year
                                              .toString(),
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                    ),
                                    Text(
                                      "Read more",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.blue),
                                    ),
                                    Icon(Icons.arrow_right)
                                  ],
                                ),
                                onTap: () {
                                  openDetails(
                                      context, categories, index, service);
                                  final DocumentReference postRef = Firestore
                                      .instance
                                      .document('categories/' +
                                          categories.elementAt(index).getKey());
                                  Firestore.instance
                                      .runTransaction((Transaction tx) async {
                                    DocumentSnapshot postSnapshot =
                                        await tx.get(postRef);
                                    if (postSnapshot.exists) {
                                      await tx.update(
                                          postRef, <String, dynamic>{
                                        'views': postSnapshot.data['views'] + 1
                                      });
                                    }
                                  });

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CategoryDetails(
                                                category:
                                                    categories.elementAt(index),
                                                service: service,
                                              )));
                                },
                              )
                            ],
                          )
                        ],
                      ))));
        },
      )),
    );
  }
}

_launchURL(String url1) async {
  String url = url1;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    //ToDo
  }
}

_launchCALL(String number) async {
  String url = "tel://" + number;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    //ToDo
  }
}

void openDetails(BuildContext context, List<CategoryModel> categories,
    int index, ServiceModel service) {
  final DocumentReference postRef = Firestore.instance
      .document('categories/' + categories.elementAt(index).getKey());
  Firestore.instance.runTransaction((Transaction tx) async {
    DocumentSnapshot postSnapshot = await tx.get(postRef);
    if (postSnapshot.exists) {
      await tx.update(
          postRef, <String, dynamic>{'views': postSnapshot.data['views'] + 1});
    }
  });

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => CategoryDetails(
                category: categories.elementAt(index),
                service: service,
              )));
}
