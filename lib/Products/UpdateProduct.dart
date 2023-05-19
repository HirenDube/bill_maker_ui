import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "UpdateProduct",bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: Text("UpdateProduct",style: TextStyle(
          fontSize: 40
        ),),
      ),
    );
  }
}
