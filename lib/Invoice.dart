import 'dart:convert';
import 'dart:typed_data';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  Map dataP = {
    "productName": ["null"]
  };
  Map dataC = {};
  List<String> uname = <String>["tom"], pname = <String>[];
  int total = 0, invoiceNo = 1;
  bool saved = false;
  List productNames = [];

  ScreenshotController ssController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    getDATA();
    productNames = dataP["productName"];
    print(productNames);
    super.initState();
  }

  void getDATA() async {
    SharedPreferences getDATA = await SharedPreferences.getInstance();
    if ((getDATA.getString("Invoice") != null)
        // && (getDATA.getString("InvoiceCusData") != null)&&
        // (getDATA.getString("Users") != null) &&
        // (getDATA.getString("Passes") != null)
        ) {
      String dataStringP = getDATA.getString("Invoice")!;
      String dataStringC = getDATA.getString("InvoiceCusData")!;
      uname = getDATA.getStringList("Users")!;
      pname = getDATA.getStringList("Passes")!;
      dataP = await jsonDecode(dataStringP);
      dataC = await jsonDecode(dataStringC);
      if (getDATA.getInt("InvoiceNo") != null) {
        invoiceNo = getDATA.getInt("InvoiceNo")!;
      }
      setState(() {});
      if (total == 0) {
        for (int l in dataP["price"]) {
          total += l;
        }
      }
      print("$uname\n\n$pname\n\n$dataP\n\n$dataC");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Invoice",
          bgColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getDATA();
                  });
                },
                icon: Icon(Icons.refresh)),
            IconButton(
                onPressed: () async {
                  SharedPreferences invoicceNo =
                      await SharedPreferences.getInstance();
                  if (!saved) {
                    invoiceNo++;
                    invoicceNo.setInt("InvoiceNo", invoiceNo);
                    saved = true;
                  } //
                  ssController.capture().then((imageBytes) {
                    if (imageBytes != null) {
                      saveImage(imageBytes);
                    }
                  });
                },
                icon: Icon(Icons.save)),
          ]),
      body: Screenshot(
        controller: ssController,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.black)),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "  SALES INVOICE",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                      Text(
                        " @${uname[0]}  ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "Date of Issue.  \n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey),
                                        children: [
                                      TextSpan(
                                          text:
                                              "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black))
                                    ])),
                                RichText(
                                    text: TextSpan(
                                        text: "Invoice No.  \n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey),
                                        children: [
                                      TextSpan(
                                          text: "      $invoiceNo",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black))
                                    ])),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 5,
                              text: TextSpan(
                                  text: "Billed To.\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.grey),
                                  children: [
                                    TextSpan(
                                        text: "${dataC["cusName"]}\n"
                                            "${dataC["cusMNo"]}\n"
                                            "${dataC["cusAd"]}\n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Colors.black,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Divider(
                      thickness: 3,
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                      child: DataTable(columns: [
                        DataColumn(
                            label: Text(
                          "Product Name",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8)),
                        )),
                        DataColumn(
                            label: Text("Quantity",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8)))),
                        DataColumn(
                            label: Text("Price ",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8))))
                      ], rows: [
                        for (int a = 0; a < dataP["productName"].length; a++)
                          DataRow(cells: [
                            DataCell(Text("${dataP["productName"][a]}")),
                            DataCell(Center(child: Text("1" /*Quantity*/))),
                            DataCell(
                                Center(child: Text("${dataP["price"][a]}"))),
                          ])
                      ]),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Sub Total\n",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                              Text("Tax\n",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                              Text("Total\n",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                              Text("Total Amount to be Paid",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("$total.00 ₹\n",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                              Text("0.00 ₹\n",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                              Text("$total.00 ₹\n",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                              Text("$total.00 ₹",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8))),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future saveImage(Uint8List imageBytes) async {
    await [Permission.storage].request();
    await ImageGallerySaver.saveImage(imageBytes,
        name: "${uname[0]} Invoice No. $invoiceNo.jpg");
  }
}
