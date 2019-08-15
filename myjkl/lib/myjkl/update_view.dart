import 'package:flutter/material.dart';
import 'package:myjkl/model/update_model.dart';
import 'package:myjkl/model/service_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateView {
  Widget getContainerList(
      BuildContext context, List<UpdateModel> updates, ServiceModel service) {
    return Container(
      child: Column(
          children: List.generate(
        updates.length,
        (index) {
          return Card(
              color: Colors.white12,
              elevation: 3.0,
              //heightFactor: 5.0,
              child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.white),
                  child: Container(
                      width: 1000,
                      child: Column(children: <Widget>[
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
                                  updates
                                          .elementAt(index)
                                          .getDay()
                                          .day
                                          .toString() +
                                      "." +
                                      updates
                                          .elementAt(index)
                                          .getDay()
                                          .month
                                          .toString() +
                                      "." +
                                      updates
                                          .elementAt(index)
                                          .getDay()
                                          .year
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        updates.elementAt(index).getContent().length > 0
                            ? InkWell(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: List.generate(
                                            updates
                                                .elementAt(index)
                                                .getContent()
                                                .length, (contentIndex) {
                                          return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                updates
                                                            .elementAt(index)
                                                            .getContent()
                                                            .elementAt(
                                                                contentIndex)
                                                            .split("<URL>")
                                                            .length ==
                                                        1
                                                    ? Text(
                                                        updates
                                                            .elementAt(index)
                                                            .getContent()
                                                            .elementAt(
                                                                contentIndex)
                                                            .split("<URL>")[0]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black))
                                                    : Text(""),
                                                updates
                                                            .elementAt(index)
                                                            .getContent()
                                                            .elementAt(
                                                                contentIndex)
                                                            .split("<URL>")
                                                            .length >
                                                        1
                                                    ? InkWell(
                                                        child: Text(
                                                            updates
                                                                .elementAt(
                                                                    index)
                                                                .getContent()
                                                                .elementAt(
                                                                    contentIndex)
                                                                .split(
                                                                    "<URL>")[0]
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .blue)),
                                                        onTap: () {
                                                          String url = updates
                                                              .elementAt(index)
                                                              .getContent()
                                                              .elementAt(
                                                                  contentIndex)
                                                              .split("<URL>")[1]
                                                              .toString()
                                                              .trim();
                                                          _launchURL(url);
                                                        })
                                                    : Text(""),
                                              ]);
                                        }))),
                              )
                            : Text(""),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 8.0),
                        ),
                        updates.elementAt(index).getImage().isNotEmpty
                            ? InkWell(
                                child: Image.network(updates
                                    .elementAt(index)
                                    .getImage()
                                    .split("<URL>")[0]),
                                onTap: () {
                                  if (updates
                                          .elementAt(index)
                                          .getImage()
                                          .split("<URL>")
                                          .length >
                                      0) {
                                    _launchURL(updates
                                        .elementAt(index)
                                        .getImage()
                                        .split("<URL>")[1]
                                        .toString()
                                        .trim());
                                  }
                                },
                              )
                            : Text(""),
                      ]))));
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
