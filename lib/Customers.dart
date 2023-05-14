import 'dart:convert';

import 'package:bill_maker_ui/AddCustomer.dart';
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
      setState(() {

      });
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
                      MaterialPageRoute(builder: (context) => AddCustomer())),
                  icon: Icon(Icons.add_circle_outline)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      getCusData();
                    });
                    print(displayedCusData);
                  },
                  icon: Icon(Icons.refresh)),
              IconButton(
                  onPressed: () async {
                    SharedPreferences clearData =
                        await SharedPreferences.getInstance();
                    clearData.remove("Customers");
                  },
                  icon: Icon(Icons.clear))
            ]),
        body: ListView.builder(
            itemCount: displayedCusData["cusName"].length,
            itemBuilder: (BuildContext context, int index) => Card(
                  color: Theme.of(context).secondaryHeaderColor,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(isThreeLine: true,
                      style: ListTileStyle.drawer,
                      onTap: () {
                        // print(displayedCusData);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Text(
                             "${displayedCusData["cusName"][index]}"),
                      // title: Text(
                      //        "Name          : ${displayedCusData["cusName"][index]}"),
                      subtitle: Text(
                        "---------------------------------------------------------------------\n${displayedCusData["cusMNo"][index]}\n"
                        "${(displayedCusData["cusAd"][index]) != null ? (displayedCusData["cusAd"][index]) : "No Address"}",
                        selectionColor: Colors.blue,
                        softWrap: true,
                        textAlign: TextAlign.left,
                      ),
                      // subtitle: Text(
                      //   "Mo.              :  ${displayedCusData["cusMNo"][index]}\n"
                      //   "Address      : ${(displayedCusData["cusAd"][index]) != null ? (displayedCusData["cusAd"][index]) : "No Address"}",
                      //   selectionColor: Colors.blue,
                      //   softWrap: true,
                      //   textAlign: TextAlign.left,
                      // ),
                      leading: Icon(Icons.account_circle_outlined),
                    ),
                  ),
                )));
  }
}
