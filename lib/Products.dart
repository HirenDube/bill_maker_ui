import 'dart:convert';

import 'package:bill_maker_ui/AddProduct.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UpdateProduct.dart';

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
                    MaterialPageRoute(builder: (context) => AddProduct())),
                icon: Icon(Icons.add_circle_outline)),
            IconButton(
                onPressed: () {
                  setState(() {
                    getDataBase();
                  });
                },
                icon: Icon(Icons.refresh)),
            IconButton(
                onPressed: () async {
                  SharedPreferences clearData =
                      await SharedPreferences.getInstance();
                  setState(() {
                    for(bool ij in selection){
                      if(ij){

                      }
                    }
                    // clearData.remove("Products");
                  });
                },
                icon: Icon(Icons.done_all))
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
              }
              else {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateProduct()));
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
                : Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
