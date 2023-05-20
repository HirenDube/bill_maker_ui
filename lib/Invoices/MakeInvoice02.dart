import 'dart:convert';
import 'dart:io';

import 'package:bill_maker_ui/Invoices/Invoice.dart';
import 'package:bill_maker_ui/Products/AddProduct.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakeInvoice2 extends StatefulWidget {
  Map invoiceCusData = {};

  MakeInvoice2({required this.invoiceCusData});

  @override
  State<MakeInvoice2> createState() => _MakeInvoice2State();
}

class _MakeInvoice2State extends State<MakeInvoice2> {
  Map displayProductData = {};
  Map invoice = {
    "productName": [],
    "price": <int>[],
  };
  List<bool> selection = <bool>[];

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Products") != null) {
      String dataString = getData.getString("Products")!;
      displayProductData = jsonDecode(dataString);
      selection = List.generate(
          displayProductData["productName"].length, (index) => false);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: Icon(Icons.add)),
      appBar: buildAppBar(
          title: "MakeInvoice : Select Products",
          bgColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getData();
                  });
                },
                icon: Icon(Icons.refresh))
          ]),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.deepOrangeAccent,
            leading: Spacer(),
            title: Text(Platform.isWindows
                ? "Customer Name : ${widget.invoiceCusData["cusName"]}"
                : "${widget.invoiceCusData["cusName"]}"),
          ),
          SliverFillRemaining(
              child: ListView.builder(
                  itemCount: displayProductData["productName"].length != null
                      ? displayProductData["productName"].length
                      : 0,
                  itemBuilder: (context, index) => Card(
                        child: CheckboxListTile(
                          title: Text(
                              "${displayProductData["productName"][index]}"),
                          subtitle:
                              Text("${displayProductData["price"][index]} ₹"),
                          value: selection[index],
                          onChanged: (bool? value) {
                            setState(() {
                              selection[index] = value!;
                            });
                          },
                        ),
                      )))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
            onPressed: () {
              if (selection.contains(true)) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Two Step Verification ..."),
                          actions: [
                            TextButton.icon(
                              onPressed: () async {
                                print("Invoice Generated");
                                for (int x = 0;
                                    x <
                                        displayProductData["productName"]
                                            .length;
                                    x++) {
                                  if (selection[x]) {
                                    invoice["productName"].add(
                                        displayProductData["productName"][x]);
                                    invoice["price"]
                                        .add(displayProductData["price"][x]);
                                  }
                                }
                                SharedPreferences setData =
                                    await SharedPreferences.getInstance();
                                String dataStringP = jsonEncode(invoice);
                                String dataStringC =
                                    jsonEncode(widget.invoiceCusData);

                                setData.setString("Invoice", dataStringP);
                                setData.setString(
                                    "InvoiceCusData", dataStringC);
                                print(dataStringP);
                                setState(() {});
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Invoice()));
                              },
                              label: Text(
                                "Make Invoice",
                                style: TextStyle(color: Colors.green),
                              ),
                              icon: Icon(
                                Icons.receipt,
                                color: Colors.green,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                print("Invoice Not Generated");
                                Navigator.pop(context);
                              },
                              label: Text(
                                "Go Back",
                                style: TextStyle(color: Colors.red),
                              ),
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ));
              } else {
                Fluttertoast.showToast(
                    msg:
                        "Please at least select one product to make an invoice");
              }
            },
            child: Text("Make Invoice")),
      ),
    );
  }
}
