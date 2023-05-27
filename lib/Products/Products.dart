// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bill_maker_ui/Products/AddProduct.dart';
import 'package:bill_maker_ui/Products/UpdateProduct.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Map displayedProductData = {
    "productName": [],
    "productId": [],
    "price": [],
    "stock": []
  };

  bool readyToDelete = false;
  List<bool> selection = <bool>[];
  List removedSelection = [null];

  @override
  void initState() {
    // TODO: implement initState
    getDataBase();
    super.initState();
  }

  void getDataBase() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Products") != null) {
      displayedProductData = jsonDecode(getData.getString("Products")!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Products",
          bgColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddProduct())),
                icon: const Icon(Icons.add_circle_outline)),
            IconButton(
                onPressed: () {
                  setState(() {
                    getDataBase();
                  });
                },
                icon: const Icon(Icons.refresh)),
            Visibility(
              visible: readyToDelete,
              child: IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "Are you sure you want to delete these products ?"),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    SharedPreferences clearData =
                                        await SharedPreferences.getInstance();

                                    for (int i = 0;
                                        i <
                                            displayedProductData["productName"]
                                                .length;
                                        i++) {
                                      if (selection[i]) {
                                        displayedProductData["productName"]
                                            .removeAt(i);

                                        displayedProductData["productId"]
                                            .removeAt(i);

                                        displayedProductData["price"]
                                            .removeAt(i);

                                        displayedProductData["stock"]
                                            .removeAt(i);
                                      }
                                    }
                                    setState(() {
                                      clearData.setString("Products",
                                          jsonEncode(displayedProductData));
                                    });
                                    selection = List.generate(
                                        (displayedProductData["productName"])
                                            .length,
                                        (index) => false);
                                    Navigator.pop(context);

                                    SnackBar snkbar = SnackBar(
                                      content: const Text(
                                          "Products removed successfully ..."),
                                      behavior: SnackBarBehavior.floating,
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                      showCloseIcon: true,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    );
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snkbar);
                                  },
                                  child: const Text("YES",
                                      style: TextStyle(color: Colors.red))),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "NO",
                                    style: TextStyle(color: Colors.green),
                                  )),
                            ],
                          )),
                  icon: const Icon(Icons.done_all)),
            )
          ]),
      body: ListView.builder(
        itemCount: displayedProductData["productName"].length,
        itemBuilder: (BuildContext context, int index) => Card(
          elevation: 3,
          color: Theme.of(context).secondaryHeaderColor,
          child: ListTile(
            style: ListTileStyle.drawer,
            onLongPress: () {
              setState(() {
                readyToDelete = !readyToDelete;
                selection = List.generate(
                    (displayedProductData["productName"]).length,
                    (index) => false);
              });
            },
            onTap: () {
              if (readyToDelete) {
                setState(() {
                  selection[index] = !selection[index];
                });
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateProduct(
                          name: displayedProductData["productName"][index],
                          id: displayedProductData["productId"][index],
                          price: displayedProductData["price"][index],
                          stock: displayedProductData["stock"][index],
                        )));
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(displayedProductData["productName"][index]),
            subtitle: Text("Id : ${displayedProductData["productId"][index]}"),
            trailing: Text("Price  : ${displayedProductData["price"][index]} ₹"
                "\nStock : ${displayedProductData["stock"][index]} pieces"),
            // Text("GST : ${displayedData["gst"][index]} %"),
            leading: readyToDelete
                ? Checkbox(
                    value: selection[index],
                    onChanged: (ckecked) {
                      setState(() {
                        selection[index] = ckecked!;
                      });
                    })
                : const Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
