import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "AboutUs",bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: Text("AboutUs",style: TextStyle(
          fontSize: 40
        ),),
      ),
    );
  }
}
