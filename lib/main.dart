import 'package:flutter/material.dart';
import 'package:langfella2/pages/main_page_bottom_nav.dart';
import 'pages/main_page_bottom_nav.dart';

void main() {
  runApp(Langfella());
}

class Langfella extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Book List App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Colors.tealAccent,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            padding: EdgeInsets.all(12),
          ),
          textTheme: TextTheme(headline6: TextStyle(fontSize: 18)),
        ),
        home: BottomNavigation(),
      );
}
