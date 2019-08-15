import 'package:flutter/material.dart';
import 'package:myjkl/model/category_model.dart';
import 'package:myjkl/model/update_model.dart';
import 'package:myjkl/myjkl/fab_comment_handler.dart';
import 'package:myjkl/myjkl/category_summary.dart';
import 'package:myjkl/model/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myjkl/myjkl/update_view.dart';

// Class for services list.
class Service extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new _ServiceViewState().build(context);
  }
}

class ServiceView extends StatefulWidget {
  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
  Widget build(BuildContext context) {
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: new StreamBuilder(
          stream: Firestore.instance
              .collection("services")
              .where("isReviewed", isEqualTo: true)
              .orderBy("order")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator(
                backgroundColor: Colors.blue[50],
                value: 5.0,
              );
            } else {
              return new DefaultTabController(
                length: snapshot.data.documents.length,
                child: new StreamBuilder(
                    stream: Firestore.instance
                        .collection("services")
                        .where("isReviewed", isEqualTo: true)
                        .orderBy("order")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return LinearProgressIndicator(
                          backgroundColor: Colors.blue[50],
                          value: 5.0,
                        );
                      } else {
                        List<ServiceModel> services = buildServiceList(
                            snapshot, snapshot.data.documents.length);
                        return serviceBody(context, services);
                      }
                    }),
              );
            }
          }),
    );
  }
}

Widget serviceBody(BuildContext context, List<ServiceModel> services) {
  return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        bottom: TabBar(
          tabs: List.generate(services.length, (index) {
            // print("tab name .......... " + stores.elementAt(index).getStoreName());
            return Tab(
              text: services.elementAt(index).getName(),
            );
          }),
          isScrollable: true,
          indicatorColor: Color.fromARGB(500, 200, 100, 600),
          unselectedLabelColor: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'MyJKL',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: TabBarView(
          children: List.generate(services.length, (index1) {
        return serviceTabBody(services.elementAt(index1));
      })),
      floatingActionButton: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FABCommentHandler()));
            },
            tooltip: 'add',
            child: Icon(Icons.feedback),
            heroTag: "btn1",
          ),
        ],
      ));
}

List<ServiceModel> buildServiceList(AsyncSnapshot snapshot, int count) {
  List<ServiceModel> services = [];

  for (var i = 0; i < count; i++) {
    String key = snapshot.data.documents[i].documentID;
    String name = snapshot.data.documents[i]["name"];
    String notice = snapshot.data.documents[i]["notice"];
    bool isReviewed = snapshot.data.documents[i]["isReviewed"];
    bool isnews = snapshot.data.documents[i]["isnews"];
    List<String> ads = List.from(snapshot.data.documents[i]["ads"]);
    String statement = snapshot.data.documents[i]["statement"];
    String privacy = snapshot.data.documents[i]["privacy"];

    services.add(new ServiceModel(
        key, name, notice, isReviewed, ads, statement, isnews, privacy));
  }
  return services;
}

Widget serviceTabBody(ServiceModel service) {
  if (service.isnews) {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection("updates")
            .where("isReviewed", isEqualTo: true)
            .orderBy("day", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator(
              backgroundColor: Colors.blue,
              value: 5.0,
            );
          } else {
            List<UpdateModel> updates =
                buildUpdateList(snapshot, snapshot.data.documents.length);
            return updateView(context, updates, service);
          }
        });
  } else {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection("categories")
            .where("service", isEqualTo: service.getName())
            .where("isReviewed", isEqualTo: true)
            .orderBy("order")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator(
              backgroundColor: Colors.blue,
              value: 5.0,
            );
          } else {
            List<CategoryModel> categories =
                buildCategoryList(snapshot, snapshot.data.documents.length);
            return categoryView(context, categories, service);
          }
        });
  }
}

List<UpdateModel> buildUpdateList(AsyncSnapshot snapshot, int count) {
  List<UpdateModel> updates = [];

  for (var i = 0; i < count; i++) {
    String key = snapshot.data.documents[i].documentID;
    List<String> content = List.from(snapshot.data.documents[i]["content"]);
    Timestamp t = snapshot.data.documents[i]["day"];
    DateTime day = t.toDate();

    String image = snapshot.data.documents[i]["image"];
    bool isReviewed = snapshot.data.documents[i]["isReviewed"];

    UpdateModel updateObj =
        new UpdateModel(key, content, day, image, isReviewed);

    updates.add(updateObj);
  }

  return updates;
}

List<CategoryModel> buildCategoryList(AsyncSnapshot snapshot, int count) {
  List<CategoryModel> categories = [];

  for (var i = 0; i < count; i++) {
    String key = snapshot.data.documents[i].documentID;

    String name = snapshot.data.documents[i]["name"];
    String service = snapshot.data.documents[i]["service"];
    String link = snapshot.data.documents[i]["link"];
    Timestamp t = snapshot.data.documents[i]["updated"];

    DateTime updated = t.toDate();
    String summary = snapshot.data.documents[i]["summary"];
    String contact = snapshot.data.documents[i]["contact"];
    String detail = snapshot.data.documents[i]["detail"];
    String hotline = snapshot.data.documents[i]["hotline"];
    int views = snapshot.data.documents[i]["views"];
    List<String> detailLink =
        List.from(snapshot.data.documents[i]["detailLink"]);
    List<String> contactList =
        List.from(snapshot.data.documents[i]["contactList"]);

    CategoryModel categoryObj = new CategoryModel(key, service, name, link);
    categoryObj.setContact(contact);
    categoryObj.setDetail(detail);
    categoryObj.setSummary(summary);
    categoryObj.setUpdated(updated);
    categoryObj.setDetailLink(detailLink);
    categoryObj.setViews(views);
    categoryObj.setHotline(hotline);
    categoryObj.setContactList(contactList);

    categories.add(categoryObj);
  }

  return categories;
}

Widget categoryView(BuildContext context, List<CategoryModel> categories,
    ServiceModel service) {
  CategorySummary object = new CategorySummary();
  return ListView(scrollDirection: Axis.vertical, children: <Widget>[
    service.getNotice().isNotEmpty
        ? Container(
            margin: EdgeInsets.all(8.0),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.blue),
            child: Text(
              " -" + service.getNotice().replaceAll("\\n", "\n" + " -"),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ))
        : Text(""),
    (service.getAds() != null && service.getAds().length > 0)
        ? Container(
            margin: EdgeInsets.all(8.0),
            height: 180,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.black26),
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: new Image.network(
                    service.getAds().elementAt(index).split("<URL>")[0],
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    String name =
                        service.getAds().elementAt(index).split("<URL>")[1];
                    _launchURL(name.trim());
                  },
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              // autoplay: true,

              itemCount: service.getAds().length,
              itemWidth: 300.0,
              itemHeight: 150,
              layout: SwiperLayout.STACK,

              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ))
        : Text(""),
    object.getContainerList(context, categories, service),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Center(
        child: InkWell(
            child: Text(service.getPrivacy().split("<URL>")[0].toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue)),
            onTap: () {
              String url =
                  service.getPrivacy().split("<URL>")[1].toString().trim();
              _launchURL(url);
            }),
      ),
    )
  ] //
      );
}

Widget updateView(
    BuildContext context, List<UpdateModel> updates, ServiceModel service) {
  UpdateView updateViewObj = new UpdateView();
  return ListView(scrollDirection: Axis.vertical, children: <Widget>[
    service.getNotice().isNotEmpty
        ? Container(
            margin: EdgeInsets.all(8.0),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.blue),
            child: Text(
              " -" + service.getNotice().replaceAll("\\n", "\n" + " -"),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ))
        : Text(""),
    (service.getAds() != null && service.getAds().length > 0)
        ? Container(
            margin: EdgeInsets.all(8.0),
            height: 180,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.black26),
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: new Image.network(
                    service.getAds().elementAt(index).split("<URL>")[0],
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    String name =
                        service.getAds().elementAt(index).split("<URL>")[1];
                     _launchURL(name.trim());
                  },
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              itemCount: service.getAds().length,
              itemWidth: 300.0,
              itemHeight: 150,
              layout: SwiperLayout.STACK,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ))
        : Text(""),
    updateViewObj.getContainerList(context, updates, service),
  ]);
}

_launchURL(String url1) async {
  String url = url1;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    //ToDo
  }
}
