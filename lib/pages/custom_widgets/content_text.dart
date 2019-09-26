import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  CustomText({this.text});

  static String _text;

  @override
  Widget build(BuildContext context) {
    _text = text;

    final TextEditingController _controller =
        TextEditingController(text: _text);

    textListener() {
      TextSelection selection = _controller.selection;
      if (selection.start >= 0) {
        String selectedText =
            _controller.text.substring(selection.start, selection.end);
        if (selectedText != "") {
          _addWordDialog(context, selectedText);
        }
      }
    }

    _controller.addListener(textListener);

    return TextField(
      maxLines: 100000,
      readOnly: true,
      textAlign: TextAlign.left,
      controller: _controller,
      enableInteractiveSelection: true,
    );
  }
}

Future<void> _addWordDialog(BuildContext context, String selectedText) async {
  return showDialog<void>(
    barrierDismissible: false, // user must tap button!
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Kelime islemi'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(selectedText),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text('Kelime cevirisi')
            ],
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text("Kelimelere ekle"),
            onPressed: () {
              //TODO add word to db
            },
          ),
          FlatButton(
            child: Text('Iptal'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
