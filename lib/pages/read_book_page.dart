import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:langfella2/pages/custom_widgets/content_text.dart';
import 'package:langfella2/models/book.dart';

class ReadBook extends StatefulWidget {
  final String bookTitle;

  ReadBook(this.bookTitle, {Key key}) : super(key: key);

  @override
  _ReadBookState createState() => _ReadBookState();
}

//TODO back arrow missing, swipe left to pop blocked by drawer
/// drawer and lack of arrow may cause iOS apps to block turning back to prev screen
class _ReadBookState extends State<ReadBook> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _currChapter;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSingleBook(widget.bookTitle),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Book _book = snapshot.data;
            return Scaffold(
                appBar: AppBar(title: Text("Read a Book")),
                drawer: Drawer(
                  child: ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _book.title,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                _book.author,
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                        ),
                        for (String c in _book.chapters)
                          ListTile(
                            title: Text(
                              'Chapter ' +
                                  (_book.chapters.indexOf(c) + 1).toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              setState(() {
                                _currChapter = c;
                              });

                              Navigator.pop(context);
                            },
                          )
                      ]),
                ),
                body: Container(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: CustomText(
                        text: ((_currChapter != null)
                            ? _currChapter
                            : (_book.currentChapterIndex != null)
                                ? _book.chapters[_book.currentChapterIndex]
                                : _book.chapters[0]),
                      )),
                ));
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
}

Future<Book> getSingleBook(bookName) async {
  final String _localHost = "http://192.168.2.61";
  final String url = _localHost + ':8080/books/' + bookName;

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Book.fromJSON(data))
      .first;
}

// IF SOME DAY YOU WANT TO USE DRAWER AS A SEPARATE WIDGET ...
class DrawChapters extends StatelessWidget {
  final List<dynamic> _chapters;

  DrawChapters(this._chapters);

  @override
  Widget build(BuildContext context) {
    List<Widget> _chapterWidgets = <Widget>[];

    _chapterWidgets.add(
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
    );

    for (int i = 0; i < _chapters.length; i++) {
      _chapterWidgets.add(ListTile(
        title: Text('Chapter ' + (i + 1).toString()),
        onTap: () {
          //TODO set the content to selected chapter
          setState() {}
        },
      ));
    }

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: _chapterWidgets,
    );
  }
}
