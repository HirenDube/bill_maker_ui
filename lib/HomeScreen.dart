import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String abc =  'initial commit pusshed';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(title: "App Login"),
    );
  }
}
