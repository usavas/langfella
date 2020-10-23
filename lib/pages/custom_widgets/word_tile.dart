import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WordTile extends StatelessWidget {
  final String word;
  final String translation;

  WordTile(this.word, this.translation);

  @override
  Widget build(BuildContext context) {
    return SlideWidget(FlipCardCustom(word, translation));
  }
}

class FlipCardCustom extends StatelessWidget {
  final String _word;
  final String _translation;

  FlipCardCustom(this._word, this._translation);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      flipOnTouch: true,
      direction: FlipDirection.HORIZONTAL,
      front: Card(
          child: Container(
        height: 100,
//            padding: EdgeInsets.only(top: 40, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _word,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
      back: Card(
        child: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                _translation,
                maxLines: 2,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'some text goes here',
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final Widget _childWidget;

  SlideWidget(this._childWidget);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.20,
      child: _childWidget,
//      actions: <Widget>[
//
//        new IconSlideAction(
//          caption: 'Share',
//          color: Colors.indigo,
//          icon: Icons.share,
//          onTap: () => _showSnackBar(context, 'Share'),
//        ),
//      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar(context, 'Archived'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _showSnackBar(context, 'Deleted'),
        ),
        IconSlideAction(
          caption: 'Ogrendim',
          color: Colors.green,
          icon: Icons.verified_user,
          onTap: () => _showSnackBar(context, 'Marked as learnt'),
        )
      ],
    );
  }

  _showSnackBar(BuildContext context, String action) {
    final snackBar = SnackBar(
      content: Text(action),
      action: SnackBarAction(
        label: 'Geri Al',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
