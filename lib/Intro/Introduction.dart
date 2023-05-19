import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Introduction",style: TextStyle(
            fontSize: 40
          ),),
        ),
      ),
    );
  }
}
