import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:langfella2/models/book_info.dart';
import 'package:langfella2/pages/custom_widgets/book_info_grid_tile.dart';
import 'package:http/http.dart' as http;

import 'book_catalogue_page.dart';


final String _localHost = "http://192.168.2.61";

class HeroPage extends StatefulWidget {
  HeroPage({Key key})
      : super(key: key);

  @override
  State createState() {
    return _HeroPageState();
  }
}

class _HeroPageState extends State<HeroPage> {
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
      body: _scrollView(context),
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

  Widget _scrollView(BuildContext context) {
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 0.65,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  padding: _edgeInsetsForIndex(index),
                  child: BookInfoGridTile(_books[index], true)
                );
              },
              childCount: _books.length,
            ),
          )
          ,
        ]        ,
      ),

    );
  }

  EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return EdgeInsets.only(top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return EdgeInsets.only(top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
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
