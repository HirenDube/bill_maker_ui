import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class Invoice extends StatefulWidget {
  List invoice;

  Invoice({required this.invoice});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Invoice", bgColor: Theme.of(context).primaryColor),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text("${widget.invoice.contains({
                    "cusName": <String>[]
                  }) ? widget.invoice[widget.invoice.indexOf({
                      "cusName": <String>[]
                    })]["cusName"] : "No Name"}"),
            ),Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text("${widget.invoice.contains({
                    "cusName": <String>[]
                  }) ? widget.invoice[widget.invoice.indexOf({
                      "cusName": <String>[]
                    })]["cusName"] : "No Name"}"),
            ),Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text("${widget.invoice.contains({
                    "cusName": <String>[]
                  }) ? widget.invoice[widget.invoice.indexOf({
                      "cusName": <String>[]
                    })]["cusName"] : "No Name"}"),
            ),
          ],
        ),
      ),
    );
  }
}
