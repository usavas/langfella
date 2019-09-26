import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:langfella2/models/book_info.dart';

class AddBookPage extends StatelessWidget {
  final BookInfo bookInfo;

  AddBookPage({this.bookInfo});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = new TextStyle(
      color: Colors.black,
      fontSize: 18,
    );

    return Scaffold(
      appBar: AppBar(
//        title: Text(bookInfo.title),
        title: Text("Add Book (Book Details)"),
      ),
      body:
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                "book name: " + bookInfo.title,
                style: textStyle,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Text(
                  bookInfo.excerpt,
                  style: textStyle,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                      child: Text(
                        "ADD TO LIB",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        //TODO: add book to localdb (as link or whole book)
                      })
                ],
              ),
            )



          ],
        ),
      ),

    );
  }
}
