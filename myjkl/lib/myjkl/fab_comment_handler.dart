import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FABCommentHandler extends StatefulWidget {
  @override
  _FABCommentHandlerState createState() => _FABCommentHandlerState();
}

class _FABCommentHandlerState extends State<FABCommentHandler> {
  final TextEditingController teComment = TextEditingController();
  final TextEditingController teEmail = TextEditingController();
  final TextEditingController teName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Send feedback/suggestions"),
        ),
        body: Container(
            child: Form(
                child:
                    ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Text(
                  "- Want to suggest some new topic?\n- Give feedback.\n- Want to put you ads here (email required). \n- or Something should be updated?\n\nPlease send you valuable comments by filling the below form:",
                  style: TextStyle(fontSize: 18))),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
              child: TextFormField(
                controller: teName,
                decoration: const InputDecoration(labelText: 'Name(Optional)'),
                onSaved: (String value) {},
                keyboardType: TextInputType.text,
              )),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
              child: TextFormField(
                controller: teEmail,
                decoration: const InputDecoration(labelText: 'Email(Optional)'),
                onSaved: (String value) {},
                keyboardType: TextInputType.emailAddress,
              )),
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Your comment',
              ),
              maxLines: 10,
              controller: teComment,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                if (teEmail.text.isNotEmpty && !_validateEmail(teEmail.text)) {
                  _settingModalBottomSheet(context, Icons.error,
                      "Entered email is not valid.", false);
                } else {
                  Firestore.instance
                      .runTransaction((Transaction transaction) async {
                    CollectionReference reference =
                        Firestore.instance.collection('comments');
                    if (teComment.text.isNotEmpty) {
                      await reference.add({
                        "name": teName.text,
                        "email": teEmail.text,
                        "comment": teComment.text.trim(),
                        "createdOn": new DateTime.now()
                      });
                      teName.text = "";
                      teComment.text = "";
                      teEmail.text = "";

                      _settingModalBottomSheet(context, Icons.done,
                          "Thanks for your feedback.", true);
                    } else {
                      _settingModalBottomSheet(context, Icons.error,
                          "Please enter a comment.", false);
                    }
                  });
                }
              },
              child: Text('Submit'),
            ),
          ),
        ]))));
  }
}

void _settingModalBottomSheet(
    context, IconData icon, String text, bool isSuccess) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(icon),
                  title: new Text(text),
                  onTap: () => {isSuccess ? Navigator.pop(context) : ""}),
            ],
          ),
        );
      });
}

bool _validateEmail(String value) {
  if (value.isEmpty) {
    return false;
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return true;
  }

  // The pattern of the email didn't match the regex above.
  return false;
}
