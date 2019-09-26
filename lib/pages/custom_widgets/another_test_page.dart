import 'package:flutter/material.dart';

class AnotherTestPage extends StatefulWidget {
  @override
  _AnotherTestPageState createState() => new _AnotherTestPageState();
}

class _AnotherTestPageState extends State<AnotherTestPage> {
  String text = "Initial Text";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new Container(child: new DrawerHeader(child: new Container())),
              new Container (
                child: new Column(
                    children: <Widget>[
                      new ListTile(leading: new Icon(Icons.info),
                          onTap: () {
                            setState(() {
                              text = "info pressed";
                            });
                          }
                      ),
                      new ListTile(leading: new Icon(Icons.save),
                          onTap: () {
                            setState(() {
                              text = "save pressed";
                            });
                          }
                      ),
                      new ListTile(leading: new Icon(Icons.settings),
                          onTap: () {
                            setState(() {
                              text = "settings pressed";
                            });
                          }
                      ),

                    ]
                ),
              )
            ],
          ),
        ),
        appBar: new AppBar(title: new Text("Test Page"),),
        body: new Center(child: new Text((text)),
        ));
  }
}