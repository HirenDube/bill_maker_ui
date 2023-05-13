import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class ShowInvoices extends StatefulWidget {
  const ShowInvoices({Key? key}) : super(key: key);

  @override
  State<ShowInvoices> createState() => _ShowInvoicesState();
}

class _ShowInvoicesState extends State<ShowInvoices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "ShowInvoices",bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: Text("ShowInvoices",style: TextStyle(
          fontSize: 40
        ),),
      ),
    );
  }
}
