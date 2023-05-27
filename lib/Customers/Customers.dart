// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bill_maker_ui/Customers/AddCustomer.dart';
import 'package:bill_maker_ui/Customers/UpdateCustomer.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Coustomers extends StatefulWidget {
  const Coustomers({Key? key}) : super(key: key);

  @override
  State<Coustomers> createState() => _CoustomersState();
}

class _CoustomersState extends State<Coustomers> {
  Map displayedCusData = {
    "cusName": <String>[],
    "cusAd": <String>[],
    "cusMNo": <int>[],
  };

  List<bool> selection = <bool>[];

  bool readyToDelete = false;

  @override
  void initState() {
    // TODO: implement initState
    getCusData();
    super.initState();
  }

  void getCusData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Customers") != null) {
      displayedCusData = jsonDecode(getData.getString("Customers")!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            title: "Customers",
            bgColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AddCustomer())),
                  icon: const Icon(Icons.add_circle_outline)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      getCusData();
                    });
                  },
                  icon: const Icon(Icons.refresh)),
              Visibility(
                visible: readyToDelete,
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                    "Are you sure you want to remove these customers ?"),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      for (int j = 0;
                                          j <
                                              displayedCusData["cusName"]
                                                  .length;
                                          j++) {
                                        if (selection[j]) {
                                          displayedCusData["cusName"]
                                              .removeAt(j);
                                          displayedCusData["cusAd"].removeAt(j);
                                          displayedCusData["cusMNo"]
                                              .removeAt(j);
                                        }
                                      }
                                      SharedPreferences clearData =
                                          await SharedPreferences.getInstance();
                                      setState(() {
                                        clearData.setString("Customers",
                                            jsonEncode(displayedCusData));
                                      });

                                      selection = List.generate(
                                          displayedCusData["cusName"].length,
                                          (index) => false);
                                      Navigator.pop(context);
                                      SnackBar snackBar = SnackBar(
                                        content: const Text(
                                            "Customers removed successfully ..."),
                                        behavior: SnackBarBehavior.floating,
                                        dismissDirection:
                                            DismissDirection.horizontal,
                                        showCloseIcon: true,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    },
                                    child: const Text(
                                      "YES",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "NO",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  )
                                ],
                              )); // showDialogue
                    },
                    icon: const Icon(Icons.done_all)),
              )
            ]),
        body: ListView.builder(
            itemCount: displayedCusData["cusName"].length,
            itemBuilder: (BuildContext context, int index) => Card(
                  color: Theme.of(context).secondaryHeaderColor,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onLongPress: () {
                        setState(() {
                          readyToDelete = !readyToDelete;
                          selection = List.generate(
                              displayedCusData["cusName"].length,
                              (index) => false);
                        });
                      },
                      isThreeLine: true,
                      style: ListTileStyle.drawer,
                      onTap: () {
                        if (readyToDelete) {
                          setState(() {
                            selection[index] = !selection[index];
                          });
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UpdateCustomer(
                                    cusAd: displayedCusData["cusAd"][index],
                                    cusMNo: displayedCusData["cusMNo"][index],
                                    cusName: displayedCusData["cusName"][index],
                                  )));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Text("${displayedCusData["cusName"][index]}"),
                      // title: Text(
                      //        "Name          : ${displayedCusData["cusName"][index]}"),
                      subtitle: Text(
                        "---------------------------------------------------------------------\n${displayedCusData["cusMNo"][index]}\n"
                        "${(displayedCusData["cusAd"][index]) ?? "No Address"}",
                        selectionColor: Colors.blue,
                        softWrap: true,
                        textAlign: TextAlign.left,
                      ),
                      leading: readyToDelete
                          ? Checkbox(
                              value: selection[index],
                              onChanged: (checked) {
                                setState(() {
                                  selection[index] = checked!;
                                });
                              })
                          : const Icon(Icons.account_circle_outlined),
                    ),
                  ),
                )));
  }
}
