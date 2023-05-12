import 'package:bill_maker_ui/Register.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Bill Maker Ui"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.fill,
                image: AssetImage("assets/images/bill_ui_bg(1).jpg"),
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop))),
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Registration())),
                  label: Text("Coustomer Section"),
                  icon: Icon(Icons.forward),
                ),
                ElevatedButton.icon(
                  onPressed: null,
                  label: Text("Admin Section"),
                  icon: Icon(Icons.forward),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
