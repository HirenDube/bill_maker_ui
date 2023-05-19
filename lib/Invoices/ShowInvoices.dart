import 'dart:io';

import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ShowInvoices01.dart';

class ShowInvoices extends StatefulWidget {
  const ShowInvoices({Key? key}) : super(key: key);

  @override
  State<ShowInvoices> createState() => _ShowInvoicesState();
}

class _ShowInvoicesState extends State<ShowInvoices> {
  File? img;
  ImagePicker picker = ImagePicker();
  int invoiceNo = 0;
  List<int> inNOs= [];
  List imgPaths = <String>[], uname = <String>[];
  List<Widget> images = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    getInvoiceData();
    getInvoicePaths();
    super.initState();
  }

  Future<void> getInvoiceData() async {
    SharedPreferences invoicceNo = await SharedPreferences.getInstance();
    if (invoicceNo.getInt("InvoiceNo") != null) {
      setState(() {
        uname = invoicceNo.getStringList("Users")!;
        invoiceNo = invoicceNo.getInt("InvoiceNo")!;
      });
      getInvoicePaths();
      // getInvoicePaths();
    }
  }

  Future<void> getInvoicePaths() async {
    if (invoiceNo != 0) {
      imgPaths.clear();
      images.clear();
      for (int i = 1; i <= invoiceNo; i++) {
        imgPaths.add(
            "/storage/emulated/0/Pictures/${uname[0]}_Invoice_No.${i}.jpg");
        inNOs.add(i-1);
      }
      List<File> imageFiles = imgPaths.map((e) => File(e)).toList();
      images = imageFiles
          .map((e) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShowInvoices01( image: Image.file(e))));
                print(imgPaths);
              },
              child: Container(

                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Image.file(e,fit: BoxFit.fill,))))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            title: "ShowInvoices",
            bgColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      getInvoiceData();                print(imgPaths);

                    });
                  },
                  icon: Icon(Icons.refresh)),
              IconButton(
                  onPressed: () async {
                    XFile? fiile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    File fiile2 = File(fiile!.path);
                    setState(() {
                      if (fiile2 != null) {
                        images.add(Image.file(fiile2));
                        print(fiile.path);
                      }
                    });
                  },
                  icon: Icon(Icons.image))
            ]),
        body: invoiceNo == 0
            ? Center(
                child: Text(
                  "No Invoice is saved currently !!",
                  style: TextStyle(fontSize: 25),
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                children: images,
              ));
  }

  Future<void> pickImage() async {
    XFile? tempImgFile = await picker.pickImage(source: ImageSource.gallery);
    if (tempImgFile != null) {
      setState(() {
        img = File(tempImgFile.path);
        print(tempImgFile.path);
      });
    }
  }
}
