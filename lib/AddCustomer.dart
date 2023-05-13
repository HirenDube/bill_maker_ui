import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "MyApp",bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: Text("MyApp",style: TextStyle(
          fontSize: 40
        ),),
      ),
    );
  }
}
