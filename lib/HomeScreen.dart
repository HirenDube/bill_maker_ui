import 'package:bill_maker_ui/Customers.dart';
import 'package:bill_maker_ui/MakeInvoice.dart';
import 'package:bill_maker_ui/Products.dart';
import 'package:bill_maker_ui/Register.dart';
import 'package:bill_maker_ui/ShowInvoices.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle style =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Bill Maker Ui", bgColor: Theme.of(context).primaryColor),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/bill_ui_bg(1).jpg"),
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              navigatingButton(context,
                  text: 'Products',
                  operation: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Products()))),
              Divider(
                color: Colors.transparent,
              ),
              navigatingButton(context,
                  text: 'Customers',
                  operation: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Coustomers()))),
              Divider(
                color: Colors.transparent,
              ),
              navigatingButton(context,
                  text: 'Make Invoice',
                  operation:
                      () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MakeInvoice()))),
              Divider(
                color: Colors.transparent,
              ),
              navigatingButton(context,
                  text: 'Show Invoices',
                  operation: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ShowInvoices()))),
            ],
          ),
        ),
      ),
    );
  }

  Card navigatingButton(BuildContext context,
      {required String text, required operation()}) {
    return Card(
      shadowColor: Colors.black,
      elevation: 3,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: 230,
        child: InkWell(
          onTap: operation,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: style,
                ),
                Icon(
                  Icons.forward,
                  color: Colors.white,
                  size: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
