import 'dart:convert';

import 'package:bill_maker_ui/AddCustomer.dart';
import 'package:bill_maker_ui/AddProduct.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Map displayedData = {
    "productName": [],
    "productId": [],
    "price": [],
    "stock": []
  };

  @override
  void initState() {
    // TODO: implement initState
    getDataBase();
    super.initState();
  }

  void getDataBase() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Products") != null) {
      displayedData = jsonDecode(getData.getString("Products")!);
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
                    MaterialPageRoute(builder: (context) => AddProduct())),
                icon: Icon(Icons.add_circle_outline)),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ]),
      body: ListView.builder(
        itemCount: displayedData["productName"].length,
        itemBuilder: (BuildContext context, int index) => ListTile(style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(displayedData["productName"][index]),
          subtitle: Text("Id : ${displayedData["productId"][index]}"),
          trailing: Column(
            children: [
              Text("Price : ${displayedData["price"][index]}"),
              Text("Stock : ${displayedData["stock"][index]}")
            ],
          ),
          leading: Icon(Icons.production_quantity_limits),
        ),
      ),
    );
  }
}
