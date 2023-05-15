import 'dart:convert';

import 'package:bill_maker_ui/Invoice.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakeInvoice extends StatefulWidget {
  const MakeInvoice({Key? key}) : super(key: key);

  @override
  State<MakeInvoice> createState() => _MakeInvoiceState();
}

class _MakeInvoiceState extends State<MakeInvoice> {
  Map displayedProductData = {
        "productName": [],
        "productId": [],
        "price": [],
        "stock": []
      },
      displayedCusData = {
        "productName": [],
        "productId": [],
        "price": [],
        "stock": []
      };

  List selecters = [];

  List invoice = [
    {
      "productName": "",
      "price": "",
      "quantity": "",
    }
  ];

  String productName = "";
  int price = 0, quantity = 0;

  List<bool> selection = <bool>[];

  @override
  void initState() {
    // TODO: implement initState
    getPData();
    getCData();
    // setlectorGenerator();
    super.initState();
  }

  void getPData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    String dataString = getData.getString("Products")!;
    displayedProductData = await jsonDecode(dataString);
    print(displayedProductData);
  }

  void getCData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    String dataString = getData.getString("Customers")!;
    displayedCusData = await jsonDecode(dataString);
    print(displayedCusData);
  }

  // void setlectorGenerator() {
  //   selecters = List.generate(
  //       displayedProductData["productName"].length,
  //       (index) => Card(
  //             color: Theme.of(context).secondaryHeaderColor,
  //             child: ListTile(
  //               onTap: () {
  //                 selection[index] = !selection[index];
  //                 if (selection[index]) {
  //                   invoices.add({
  //                     "productName": displayedProductData["productName"][index],
  //                     "price": displayedProductData["price"][index],
  //                     "quantity": 1
  //                   });
  //                 } else {
  //                   invoices.removeLast();
  //                 }
  //               },
  //               title: Text("${displayedProductData["productName"][index]}"),
  //               subtitle: Text("${displayedProductData["price"][index]}"),
  //               leading: Checkbox(
  //                 value: selection[index],
  //                 onChanged: (bool? value) async {
  //                   setState(() {
  //                     selection[index] = value!;
  //                     if (selection[index]) {
  //                       invoices.add({
  //                         "productName": displayedProductData["productName"]
  //                             [index],
  //                         "price": displayedProductData["price"][index],
  //                         "quantity": 1
  //                       });
  //                     } else {
  //                       invoices.removeLast();
  //                     }
  //                   });
  //                 },
  //               ),
  //               trailing: selection[index]
  //                   ? TextFormField(
  //                       initialValue: "1",
  //                       enabled: true,
  //                       keyboardType: TextInputType.number,
  //                       decoration: InputDecoration(
  //                           filled: true,
  //                           fillColor: Colors.white,
  //                           enabledBorder: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(20))),
  //                       onChanged: (value) {
  //                         invoices.remove({
  //                           "productName": displayedProductData["productName"]
  //                               [index],
  //                           "price": displayedProductData["price"][index],
  //                           "quantity": 1
  //                         });
  //                         invoices.add({
  //                           "productName": displayedProductData["productName"]
  //                               [index],
  //                           "price": displayedProductData["price"][index],
  //                           "quantity": int.parse(value)
  //                         });
  //                       },
  //                     )
  //                   : Text(""),
  //             ),
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            title: "MakeInvoice",
            bgColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      getPData();
                      // setlectorGenerator();
                    });
                  },
                  icon: Icon(Icons.refresh))
            ]),
        body: ListView(
          children: [
            DropdownButton(items: [
              for (int k = 0; k < ((displayedCusData["productName"]) == null ? 0 : (displayedCusData["productName"].length) ); k++)
                DropdownMenuItem(value: displayedCusData["cusName"],child: Text("${displayedCusData["cusName"]}"))
            ], onChanged: (value) {
              invoice.add({"cusName" : value});
            }),
            for (int index = 0;
                index < ((displayedProductData["productName"]) == null ? 0 : (displayedProductData["productName"].length) ) ;
                index++)
              Card(
                color: Theme.of(context).secondaryHeaderColor,
                child: ListTile(
                  onTap: () {
                    selection[index] = !selection[index];
                    if (selection[index]) {
                      invoice.add({
                        "productName": displayedProductData["productName"]
                            [index],
                        "price": displayedProductData["price"][index],
                        "quantity": 1
                      });
                    } else {
                      invoice.removeLast();
                    }
                  },
                  title: Text("${displayedProductData["productName"][index]}"),
                  subtitle: Text("${displayedProductData["price"][index]}"),
                  leading: Checkbox(
                    value: selection[index],
                    onChanged: (bool? value) async {
                      setState(() {
                        selection[index] = value!;
                        if (selection[index]) {
                          invoice.add({
                            "productName": displayedProductData["productName"]
                                [index],
                            "price": displayedProductData["price"][index],
                            "quantity": 1
                          });
                        } else {
                          invoice.removeLast();
                        }
                      });
                    },
                  ),
                  trailing: selection[index]
                      ? TextFormField(
                          initialValue: "1",
                          enabled: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (value) {
                            invoice.remove({
                              "productName": displayedProductData["productName"]
                                  [index],
                              "price": displayedProductData["price"][index],
                              "quantity": 1
                            });
                            invoice.add({
                              "productName": displayedProductData["productName"]
                                  [index],
                              "price": displayedProductData["price"][index],
                              "quantity": int.parse(value)
                            });
                          },
                        )
                      : Text(""),
                ),
              ),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences setData =
                      await SharedPreferences.getInstance();
                  setData.setString("Invoice", jsonEncode(invoice));
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Invoice(invoice: invoice)));
                },
                child: Text("Make Invoice"))
          ],
        ));
  }
}
