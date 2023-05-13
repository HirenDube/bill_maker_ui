import 'package:bill_maker_ui/AddProduct.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class Coustomers extends StatefulWidget {
  const Coustomers({Key? key}) : super(key: key);

  @override
  State<Coustomers> createState() => _CoustomersState();
}

class _CoustomersState extends State<Coustomers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Coustomers",
          bgColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddCustomer())),
                icon: Icon(Icons.add_circle_outline))
          ]),
      body: ListView(
        children: [],
      ),
    );
  }
}
