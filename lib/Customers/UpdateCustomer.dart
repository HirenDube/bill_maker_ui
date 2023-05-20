import 'dart:convert';

import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateCustomer extends StatefulWidget {
  String cusName, cusAd;
  int cusMNo;

  UpdateCustomer(
      {required this.cusName, required this.cusAd, required this.cusMNo});

  @override
  State<UpdateCustomer> createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
  String cusName = "", cusAd = "";
  int cusMNo = 0;
  Map cusData = {};
  GlobalKey<FormState> _editCustomer = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    cusName = widget.cusName;
    cusMNo = widget.cusMNo;
    cusAd = widget.cusAd;
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Customers") != null) {
      cusData = jsonDecode(getData.getString("Customers")!);
      cusData["cusName"].remove(cusName);
      cusData["cusMNo"].remove(cusMNo);
      cusData["cusAd"].remove(cusAd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            title: "UpdateCustomer", bgColor: Theme.of(context).primaryColor),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            width: MediaQuery.of(context).size.width - 50,
            child: Form(
              key: _editCustomer,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: cusName,
                    onChanged: (value) {
                      cusName = value;
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "Customer Name can't be empty !!";
                      }
                    },
                    decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        labelText: "Customer Name:",
                        hintText: "Enter Customer's name here...",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    initialValue: "${cusMNo}",
                    onChanged: (value) {
                      cusMNo = int.parse(value);
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (int.tryParse(value) != null) {
                          if (value.length == 10) {
                            if (cusData["cusMNo"] != null) {
                              if (((cusData["cusMNo"])!
                                  .contains(int.parse(value)))) {
                                return "Two Customers cannot have same Mobile Numbers !!";
                              } else {
                                return null;
                              }
                            }
                          } else {
                            return "Customer Mobile No. must be of 10 digits only !!";
                          }
                        } else {
                          return "Customer Mobile No. should be a number only !!";
                        }
                      } else {
                        return "Customer Mobile No. can't be empty !!";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        labelText: "Mobile No.:",
                        hintText: "Enter Customer's Mobile NO. here...",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    initialValue: cusAd,
                    onChanged: (value) {
                      cusAd = value;
                    },
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        labelText: "Address:",
                        hintText: "Enter Customer's Address here...",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_editCustomer.currentState!.validate()) {
                          cusData["cusName"].add(cusName);
                          cusData["cusAd"].add(cusAd);
                          // cusData["cusMNo"].remove(1010101010);
                          cusData["cusMNo"].add(cusMNo);

                          SharedPreferences addData =
                              await SharedPreferences.getInstance();
                          String dataString = jsonEncode(cusData);
                          addData.setString("Customers", dataString);

                          Navigator.pop(context);

                          SnackBar snkBar = SnackBar(
                            content: Text("Customer Updated successfully"),
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            elevation: 5,
                            backgroundColor: Theme.of(context).primaryColor,
                            dismissDirection: DismissDirection.horizontal,
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snkBar);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Text(
                        " Add ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
