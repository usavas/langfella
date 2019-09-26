import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:langfella2/models/book_info.dart';
import 'package:langfella2/pages/add_book_page.dart';
import 'package:langfella2/pages/read_book_page.dart';


/// show a book's info in a row which is not responsive (one book for each whole row)
class BookInfoTile extends StatelessWidget {
  final BookInfo _bookInfo;
  final bool isAddedBooksPage;

  BookInfoTile(this._bookInfo, this.isAddedBooksPage);

  final String LOCALHOST = "http://192.168.2.61";

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Card(
            child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  LOCALHOST + ":8080/books/image/" + _bookInfo.getBookTitle(),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(flex: 2, child: BookInfoColumn(_bookInfo))
          ],
        )),
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
    return
      Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            TitleRow(_bookInfo),
            AuthorRow(_bookInfo),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: WordCountRow(_bookInfo),
            ),

            Container(
              padding: EdgeInsets.only(top: 20),
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
          size: 16,
          color: Colors.black,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Flexible(
          child: Text(
            _bookInfo.title,
            style: TextStyle(
              fontSize: 16,
            ),
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
          size: 16,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Flexible(
          child: Text(
            _bookInfo.author,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        )
      ],
    );
  }
}

class WordCountRow extends StatelessWidget {
  final BookInfo _bookInfo;

  WordCountRow(this._bookInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(
                    text: _bookInfo.totalWords.toString(),
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: ' kelime'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2),
          ),
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(
                    text: _bookInfo.uniqueWords.toString(),
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: ' farkli kelime'),
              ],
            ),
          )

//          Text(_bookInfo.totalWords.toString() + " kelime"),
//          Padding(
//            padding: EdgeInsets.only(top: 2),
//          ),
//          Text(_bookInfo.uniqueWords.toString() + " tekil kelime")

        ],
      ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: Colors.green.withOpacity(0.8),
                  borderRadius: new BorderRadius.all(const Radius.circular(4))),
              padding: EdgeInsets.all(2),
              child: Text(
                _bookInfo.genre,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 2),
                    decoration: new BoxDecoration(
                        color: Colors.blue.withOpacity(0.8),
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(4))),
                    padding: EdgeInsets.all(2),
                    child: Text(
                      _bookInfo.level,
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        )
      ],
    );
  }
} // colorful genre and level end
