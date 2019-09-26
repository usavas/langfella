import 'package:flutter/material.dart';

import 'package:langfella2/models/book_info.dart';
import 'package:langfella2/pages/add_book_page.dart';
import 'package:langfella2/pages/read_book_page.dart';

class BookInfoTileDeprecated extends StatelessWidget {
  final BookInfo _bookInfo;
  final bool isAddedBooksPage;
  BookInfoTileDeprecated(this._bookInfo, this.isAddedBooksPage);

  final String _localHost = "http://192.168.2.61";


  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      Card(
        child: ListTile(
          title: Text(_bookInfo.title),
          subtitle: Text(_bookInfo.author),
          leading: Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Image.network(
                _localHost + ":8080/books/image/" + _bookInfo.getBookTitle(),
                fit: BoxFit.fill,)
          ),
          onTap: () {
            if (isAddedBooksPage){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder:
                      (context) => ReadBook(_bookInfo.title))
              );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder:
                      (context) => AddBookPage(bookInfo: _bookInfo,))
              );
            }
          },
        ),
      ),
    ],
  );

}