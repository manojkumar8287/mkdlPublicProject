import 'package:flutter/material.dart';
import 'package:myjkl/model/category_model.dart';
import 'package:myjkl/model/service_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryDetails extends StatelessWidget {
  final CategoryModel category;
  final ServiceModel service;

  CategoryDetails({Key key, @required this.category, @required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(category.getName()),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ListView(children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      service.getName(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_right),
                    Text(
                      category.getName(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Container(
                    child: Text(category.getSummary(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        softWrap: true),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Container(
                    child: Text("More info",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 7.0),
                  child: Container(
                    child: Text(
                        " - " + category.getDetail().replaceAll("\\n", "\n -"),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        softWrap: true),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Container(
                    child: Text(
                      "Contact info",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                  )),
              resolveContacts(category),
              category.getDetailLink().isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      child: Container(
                        child: Text("Useful links",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ))
                  : Text(""),
              category.getDetailLink().isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 0.0),
                      child: Column(
                          children: List.generate(
                        category.getDetailLink().length,
                        (index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Column(
                                children: <Widget>[
                                  category
                                              .getDetailLink()
                                              .elementAt(index)
                                              .split("<URL>")
                                              .length >
                                          0
                                      ? Container(
                                          width: 1000,
                                          child: InkWell(
                                            child: Text(
                                              "  " +
                                                  category
                                                      .getDetailLink()
                                                      .elementAt(index)
                                                      .split("<URL>")[0],
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            onTap: () {
                                              String name = category
                                                  .getDetailLink()
                                                  .elementAt(index)
                                                  .split("<URL>")[1];
                                              _launchURL(name.trim());
                                            },
                                          ))
                                      : Text("")
                                ],
                              ));
                        },
                      )))
                  : Text(""),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                child: Center(
                  child: InkWell(
                    child: Text(
                      " find more on web",
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue),
                    ),
                    onTap: () {
                      String name = category.getLink();
                      _launchURL(name.trim());
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                child: Center(
                  child: Text(
                    service.getStatement().replaceAll("\\n", "\n"),
                    style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                    softWrap: true,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                child: Center(
                  child: InkWell(
                      child: Text(
                          service.getPrivacy().split("<URL>")[0].toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue)),
                      onTap: () {
                        String url = service
                            .getPrivacy()
                            .split("<URL>")[1]
                            .toString()
                            .trim();
                        _launchURL(url);
                      }),
                ),
              )
            ])));
  }
}

Widget resolveContacts(CategoryModel category) {
  if (category.getContactList() == null) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7.0),
        child: Container(
          child: Text(" - " + category.getContact().replaceAll("\\n", "\n - "),
              style: TextStyle(
                fontSize: 15,
              )),
        ));
  } else {
    return category.getContactList().isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Column(
                children: List.generate(
              category.getContactList().length,
              (index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Column(
                      children: <Widget>[
                        category
                                    .getContactList()
                                    .elementAt(index)
                                    .split("<NUM>")
                                    .length >
                                0
                            ? Container(
                                width: 1000,
                                child: InkWell(
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                          text: " -" +
                                              category
                                                  .getContactList()
                                                  .elementAt(index)
                                                  .split("<NUM>")[0],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        category
                                                    .getContactList()
                                                    .elementAt(index)
                                                    .split("<NUM>")
                                                    .length >
                                                1
                                            ? TextSpan(
                                                text: "  " +
                                                    category
                                                        .getContactList()
                                                        .elementAt(index)
                                                        .split("<NUM>")[1],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            : TextSpan(text: ""),
                                      ]),
                                    ),
                                    onTap: () {
                                      if (category
                                              .getContactList()
                                              .elementAt(index)
                                              .split("<NUM>")
                                              .length >
                                          1) {
                                        String name = category
                                            .getContactList()
                                            .elementAt(index)
                                            .split("<NUM>")[1];
                                        _launchCALL(name.trim());
                                      }
                                      ;
                                    }))
                            : Text("")
                      ],
                    ));
              },
            )))
        : Text("");
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
