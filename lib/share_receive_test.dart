import 'package:flutter/material.dart';
import 'package:langfella2/receive_share.dart';
import 'package:share/share.dart';

class ShareReceiveTest extends StatefulWidget {


  @override
  State createState() {
    return _ShareReceiveTestState();
  }

}

class _ShareReceiveTestState extends ReceiveShareState<ShareReceiveTest>{

  String _receivedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_receivedText),
      ),
    );
  }

  @override
  void initState() {
    enableShareReceiving();
    super.initState();
  }

  @override
  void receiveShare(Share shared) {
    print('received');
    setState(() {
      _receivedText = shared.toString();
    });

  }


}