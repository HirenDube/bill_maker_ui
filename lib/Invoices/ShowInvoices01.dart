import 'dart:io';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowInvoices01 extends StatefulWidget {

  Widget image;

  ShowInvoices01({ required this.image});

  @override
  State<ShowInvoices01> createState() => _ShowInvoices01State();
}

class _ShowInvoices01State extends State<ShowInvoices01> {
// /data/user/0/com.example.bill_maker_ui/cache/5dc63ee8-3b65-4d92-b07a-7c6aac829054/Divyang Invoice No. 9.jpg

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Invoice",
          bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: widget.image,
      ),
    );
  }
}
