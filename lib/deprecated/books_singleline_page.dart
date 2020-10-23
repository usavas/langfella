import 'package:flutter/material.dart';
import 'package:langfella2/pages/book_catalogue_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:langfella2/models/book_info.dart';
import '../pages/custom_widgets/book_info_tile.dart';

final String _localHost = "http://192.168.2.61";

class Books extends StatefulWidget {
  @override
  State createState() {
    return _BooksState();
  }
}

class _BooksState extends State<Books> {
  final List<BookInfo> _books = <BookInfo>[];

  void listenForAddingBooks() async {
    final Stream<BookInfo> stream = await getBooks();
    stream.listen((BookInfo book) => setState(() => _books.add(book)));
  }

  @override
  void initState() {
    super.initState();
    listenForAddingBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) => Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: BookInfoTile(_books[index], true),
              )),

//        new StaggeredGridView.countBuilder(
//          crossAxisCount: 4,
//          itemCount: 8,
//          itemBuilder: (BuildContext context, int index) => Container(
//                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                child: BookInfoGridTile(_books[index], true),
//              ),
//          staggeredTileBuilder: (int index) =>
//          new StaggeredTile.fit(2),
////          mainAxisSpacing: 4.0,
////          crossAxisSpacing: 4.0,
//        ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BookCatalogue()));
        },
      ),
    );
  }
}

Future<Stream<BookInfo>> getBooks() async {
  final String url = _localHost + ':8080/books/genre/fairytale';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => BookInfo.fromJSON(data));
}
