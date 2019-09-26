import 'package:flutter/material.dart';
import 'package:langfella2/pages/custom_widgets/word_tile.dart';

class Words extends StatefulWidget {
  @override
  State createState() => _WordsState();
}

class _WordsState extends State<Words> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 6),
              child: WordTile(
                  //TODO fetch and add word list and index here
                  "word",
                  "cevirisi upuzun"),
            );
          }),
    );
  }
}
