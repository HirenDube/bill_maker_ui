// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProduct extends StatefulWidget {
  String name;
  int id, price, stock;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();

  UpdateProduct(
      {super.key, required this.name,
      required this.id,
      required this.price,
      required this.stock});
}

class _UpdateProductState extends State<UpdateProduct> {
  String name = "";
  int id = 0, price = 0, stock = 0;
  Map productData = {};
  final GlobalKey<FormState> _editProduct = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    getData();
    name = widget.name;
    id = widget.id;
    price = widget.price;
    stock = widget.stock;

    super.initState();
  }

  void getData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Products") != null) {
      productData = jsonDecode(getData.getString("Products")!);
      productData["productName"].remove(name);

      productData["productId"].remove(id);
      productData["price"].remove(price);
      productData["stock"].remove(stock);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            title: "UpdateProduct", bgColor: Theme.of(context).primaryColor),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 350,
            width: MediaQuery.of(context).size.width - 50,
            child: Form(
              key: _editProduct,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: name,
                    validator: (name1) {
                      if (name1!.isNotEmpty) {
                        return null;
                      } else {
                        return "Product Name can't be empty !!";
                      }
                    },
                    onChanged: (name2) {
                      name = name2;
                    },
                    decoration: InputDecoration(
                        labelText: "Product Name : ",
                        floatingLabelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const Divider(color: Colors.transparent),
                  TextFormField(
                    initialValue: "$id",
                    validator: (id1) {
                      if (id1!.isNotEmpty) {
                        if (int.tryParse(id1) != null) {
                          if (!((productData["productId"])
                              .contains(int.parse(id1)))) {
                            return null;
                          } else {
                            return "Product ID must be unique !!";
                          }
                        } else {
                          return "Product ID must be a number !!";
                        }
                      } else {
                        return "Product ID can't be empty !!";
                      }
                    },
                    onChanged: (id2) {
                      id = int.parse(id2);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter a number only",
                        labelText: "Product ID : ",
                        floatingLabelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const Divider(color: Colors.transparent),
                  TextFormField(
                    initialValue: "$price",
                    validator: (price1) {
                      if (price1!.isNotEmpty) {
                        if (int.tryParse(price1) != null) {
                          return null;
                        } else {
                          return "Price must be a number !!";
                        }
                      } else {
                        return "Price can't be empty !!";
                      }
                    },
                    onChanged: (price2) {
                      price = int.parse(price2);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter a number only",
                        labelText: "Price : ",
                        floatingLabelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const Divider(color: Colors.transparent),
                  TextFormField(
                    initialValue: "$stock",
                    validator: (stock1) {
                      if (stock1!.isNotEmpty) {
                        if (int.tryParse(stock1) != null) {
                          return null;
                        } else {
                          return "Stock must be a number !!";
                        }
                      } else {
                        return "Stock can't be empty !!";
                      }
                    },
                    onChanged: (stock2) {
                      stock = int.parse(stock2);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter a number only",
                        labelText: "Stock : ",
                        floatingLabelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const Divider(color: Colors.transparent),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width - 50, 40),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () async {
                        if (_editProduct.currentState!.validate()) {
                          productData["productName"].add(name);
                          productData["productId"].add(id);
                          productData["price"].add(price);
                          productData["stock"].add(stock);

                          SharedPreferences addData =
                              await SharedPreferences.getInstance();
                          String value = jsonEncode(productData);
                          addData.setString("Products", value);

                          Navigator.pop(context);

                          SnackBar snackBar = SnackBar(
                            content: const Text("Product Updated Successfully"),
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            elevation: 5,
                            backgroundColor: Theme.of(context).primaryColor,
                            dismissDirection: DismissDirection.horizontal,
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          setState(() {});
                        }
                      },
                      child: const Text(
                        " Add ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
