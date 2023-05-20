import 'dart:convert';

import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  int addVerificaton = 0;
  String cusName = "", cusAd = "";
  int cusMNo = 0;

  // int cusGSTNo = 0;
  Map cusData = {
    "cusName": <String>[],
    "cusAd": <String>[],
    "cusMNo": <int>[],
  };

  // "cusGSTNo": [],

  GlobalKey<FormState> _cusDataKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Customers") != null) {
      cusData = jsonDecode(getData.getString("Customers")!);
    } else {
      getData.setString(
          "Customers", '{"cusName": [],"cusAd": [],"cusMNo": [],}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "AddCustomer", bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          width: MediaQuery.of(context).size.width - 50,
          child: Form(
            key: _cusDataKey,
            child: ListView(
              children: [
                TextFormField(
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
                      if (_cusDataKey.currentState!.validate()) {
                        if (addVerificaton != 1) {
                          addVerificaton = 1;

                          cusData["cusName"].add(cusName);
                          cusData["cusAd"].add(cusAd);
                          // cusData["cusMNo"].remove(1010101010);
                          cusData["cusMNo"].add(cusMNo);

                          SharedPreferences addData =
                              await SharedPreferences.getInstance();
                          String dataString = jsonEncode(cusData);
                          addData.setString("Customers", dataString);

                          SnackBar snkBar = SnackBar(
                            content: Text("Customer(Party) added successfully"),
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            elevation: 5,
                            backgroundColor: Theme.of(context).primaryColor,
                            dismissDirection: DismissDirection.horizontal,
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snkBar);
                        } else {
                          SnackBar snkBar = SnackBar(
                            content: Text(
                                "One Customer(Party) cannot be added twice !!"),
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
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      " Add ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
