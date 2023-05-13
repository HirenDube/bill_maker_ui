import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class MakeInvoice extends StatefulWidget {
  const MakeInvoice({Key? key}) : super(key: key);

  @override
  State<MakeInvoice> createState() => _MakeInvoiceState();
}

class _MakeInvoiceState extends State<MakeInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "MakeInvoice",bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: Text("MakeInvoice",style: TextStyle(
          fontSize: 40
        ),),
      ),
    );
  }
}
