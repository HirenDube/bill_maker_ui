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
      appBar: buildAppBar(
          title: "AddCustomer", bgColor: Theme.of(context).primaryColor),
      body: ListView(
        children: [
          TextFormField(
            onChanged: (value) {},
            validator: (value) {},
            decoration: InputDecoration(
                floatingLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                labelText: "Customer Name:",
                hintText: "Enter Customer's name here...",
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          TextFormField(
            onChanged: (value) {},
            validator: (value) {},
            decoration: InputDecoration(
                floatingLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                labelText: "Mobile No.:",
                hintText: "Enter Customer's Mobile NO. here...",
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          TextFormField(
            onChanged: (value) {},
            validator: (value) {},
            decoration: InputDecoration(
                floatingLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                labelText: "Address:",
                hintText: "Enter Customer's Address here...",
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          TextFormField(
            onChanged: (value) {},
            validator: (value) {},
            decoration: InputDecoration(
                floatingLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                labelText: "Customer's GST No. :",
                hintText: "Enter Customer's GST No. here...",
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ],
      ),
    );
  }
}
