import 'package:flutter/material.dart';

import 'package:langfella2/models/book_info.dart';
import 'package:langfella2/pages/add_book_page.dart';
import 'package:langfella2/pages/read_book_page.dart';

/// Shows a book's info in a card which is compatible for grid viewing and responsive
class BookInfoGridTile extends StatelessWidget {
  final BookInfo _bookInfo;
  final bool isAddedBooksPage;

  BookInfoGridTile(this._bookInfo, this.isAddedBooksPage);
  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Image.network(
                "http://192.168.2.61:8080/books/image/" +
                    _bookInfo.getBookTitle(),
                fit: BoxFit.cover,
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 11,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: BookInfoColumn(_bookInfo),
                            )
                          ],
                        ),
                      ))
                ],
              )
            ]),
        onTap: () {
          if (isAddedBooksPage) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReadBook(_bookInfo.title)));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddBookPage(
                          bookInfo: _bookInfo,
                        )));
          }
        },
      );
}

class BookInfoColumn extends StatelessWidget {
  final BookInfo _bookInfo;

  BookInfoColumn(this._bookInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TitleRow(_bookInfo),
          AuthorRow(_bookInfo),
          Container(
            padding: EdgeInsets.only(top: 4),
            child: GenreLevelRow(_bookInfo),
          )
        ],
      ),
    );
  }
}

class TitleRow extends StatelessWidget {
  final BookInfo _bookInfo;

  TitleRow(this._bookInfo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.book, //.getIconData("progress-0"),
          size: 12,
          color: Colors.white,
        ),
        Padding(padding: EdgeInsets.only(left: 2, right: 2)),
        Flexible(
          child: Text(
            _bookInfo.title,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class AuthorRow extends StatelessWidget {
  final BookInfo _bookInfo;

  AuthorRow(this._bookInfo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.person,
          size: 11,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
        ),
        Flexible(
          child: Text(
            _bookInfo.author,
            style: TextStyle(
                fontStyle: FontStyle.italic, fontSize: 11, color: Colors.white),
          ),
        )
      ],
    );
  }
}

// colorful genre and level
class GenreLevelRow extends StatelessWidget {
  final BookInfo _bookInfo;

  GenreLevelRow(this._bookInfo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                color: Colors.green.withOpacity(0.8),
                borderRadius: new BorderRadius.all(const Radius.circular(4))),
            padding: EdgeInsets.all(2),
            child: Text(
              _bookInfo.genre,
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
          )
        ]),
        Padding(
          padding: EdgeInsets.only(left: 2),
        ),
        Row(
          children: <Widget>[
            Container(
                decoration: new BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(4))),
                padding: EdgeInsets.all(2),
                child: Text(
                  _bookInfo.level,
                  style: TextStyle(fontSize: 11, color: Colors.white),
                )),
          ],
        )
      ],
    );
  }
} // colorful genre and level end
