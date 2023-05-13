import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "AddCustomer",bgColor: Theme.of(context).primaryColor),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
