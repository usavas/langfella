import 'package:flutter/material.dart';
import 'package:langfella2/models/word_translation.dart';
import 'package:langfella2/database/word_dao.dart';

class TestPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('save me'),
              onPressed: (){
                _save();
              },
            ),
            RaisedButton(
              child: Text('now get me'),
              onPressed: _nowGetMe,
            )
          ],
        )

      ),
    );
  }
}


_save() async {
  WordTranslation word = WordTranslation('hello', 'merhaba', 'en', 'tr');
  String res = await WordDao().wordInsert(word);
  print(res);
}

_nowGetMe() async {
  WordTranslation wt = await WordDao().wordGet('hello');
  print('inserted row: ' + wt.word);
}