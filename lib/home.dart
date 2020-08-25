import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('홈페이지 입니다')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('홈페이지 입니다'),
            OutlineButton(
              child: Text('돌아가기'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        )
      ),
    );
  }
}