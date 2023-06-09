// ignore_for_file: file_names, must_be_immutable, deprecated_member_use

import 'dart:io' show File;

import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShowInvoices01 extends StatelessWidget {

  File imageFile;

  ShowInvoices01({super.key,  required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Invoice",
          bgColor: Theme.of(context).primaryColor,actions: [IconButton(onPressed: (){
            Share.shareFiles([imageFile.path]);
      }, icon: const Icon(Icons.share))]),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
