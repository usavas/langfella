import 'package:flutter/material.dart';
import 'package:langfella2/pages/custom_widgets/book_info_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/book_info.dart';
import '../models/book.dart';
import 'package:langfella2/deprecated/book_info_tile_deprecated.dart';

class BookCatalogue extends StatefulWidget {
  @override
  _BookCatalogueState createState() => _BookCatalogueState();
}

final String LOCALHOST = "http://192.168.2.61";

class _BookCatalogueState extends State<BookCatalogue> {
  List<BookInfo> _books = <BookInfo>[];

  @override
  void initState() {
    super.initState();
    listenForBooks();
  }

  void listenForBooks() async {
    final Stream<BookInfo> stream = await getBooks();
    stream.listen((BookInfo book) => setState(() => _books.add(book)));
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text("Books Catalogue"),
        ),
        body: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) =>
              Container(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: BookInfoTile(_books[index], false),
              ),
        ),
      );
}

Future<Stream<BookInfo>> getBooks() async {
  final String url = LOCALHOST + ':8080/books';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => BookInfo.fromJSON(data));
}

//Future<Book> getSingleBook (bookName) async {
//  final String url = LOCALHOST + ':8080/books/' + bookName;
//
//  final client = new http.Client();
//  final streamedRest = await client.send(
//      http.Request('get', Uri.parse(url))
//  );
//
//  return streamedRest.stream
//      .transform(utf8.decoder)
//      .transform(json.decoder)
//      .first;
//}
