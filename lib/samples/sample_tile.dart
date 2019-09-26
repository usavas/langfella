import 'package:flutter/material.dart';

class SampleTile extends StatelessWidget {
  final String word;
  final String translation;

  SampleTile(this.word, this.translation);

  @override
  Widget build(BuildContext context) {
    return
      Card (
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                        child: Text(
                          word,
                          style:
                          TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(
                          translation,
                          maxLines: 2,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star_border,
                            size: 35.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            )
          ],
        ),
      );

  }
}
