// ignore_for_file: use_build_context_synchronously

import 'package:bill_maker_ui/Customers/Customers.dart';
import 'package:bill_maker_ui/Extras/AboutUs.dart';
import 'package:bill_maker_ui/Initial%20App%20Screens/SplashScreen.dart';
import 'package:bill_maker_ui/Invoices/MakeInvoice01.dart';
import 'package:bill_maker_ui/Invoices/ShowInvoices.dart';
import 'package:bill_maker_ui/Products/Products.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle style =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(
          title: "Bill Maker Ui",
          bgColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const AboutUs()));
                },
                icon: const Icon(Icons.info_outline))
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: const AssetImage("assets/images/bill_ui_bg(1).jpg"),
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              navigatingButton(context,
                  text: 'Products',
                  operation: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Products()))),
              const Divider(
                color: Colors.transparent,
              ),
              navigatingButton(context,
                  text: 'Customers',
                  operation: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Coustomers()))),
              const Divider(
                color: Colors.transparent,
              ),
              navigatingButton(context,
                  text: 'Make Invoice',
                  operation: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MakeInvoice1()))),
              const Divider(
                color: Colors.transparent,
              ),
              navigatingButton(context,
                  text: 'Show Invoices',
                  operation: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ShowInvoices()))),
              const Divider(
                color: Colors.transparent,
              ),
              navigatingButton(context,
                  icon: Icons.logout,
                  text: 'Logout',
                  operation: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 5,
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            title: const Text("Are you sure you want to logout ?"),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    SharedPreferences setData =
                                        await SharedPreferences.getInstance();
                                    setData.setBool("LoggedIn", false);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SplashScreen()));
                                  },
                                  child: const Text("YES")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("NO")),
                            ],
                          ))),
            ],
          ),
        ),
      ),
    );
  }

  Card navigatingButton(BuildContext context,
      {required String text,
      required Function() operation,
      IconData icon = Icons.forward}) {
    return Card(
      shadowColor: Colors.black,
      elevation: 3,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: 230,
        child: InkWell(
          onTap: operation,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: style,
                ),
                Icon(
                  icon,
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
