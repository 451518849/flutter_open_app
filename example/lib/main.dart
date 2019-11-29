import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_open_app/flutter_open_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
              onTap: () {
                String openUrl = "";
                FlutterOpenApp.openUrl(openUrl).then((res) {
                  print('result:$res');
                });
              },
              child: Container(
                child: Text('pay'),
              )),
        ),
      ),
    );
  }
}
