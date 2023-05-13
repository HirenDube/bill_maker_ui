import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: buildAppBar(title: "My App"),
      body: Center(
        child: Text(
          "My App()",
          style: TextStyle(fontSize: 50),
        ),
      ),
    ),);
  }
}
