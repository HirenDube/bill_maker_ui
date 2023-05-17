import 'dart:convert';
import 'package:bill_maker_ui/MakeInvoice(2).dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakeInvoice1 extends StatefulWidget {
  const MakeInvoice1({Key? key}) : super(key: key);

  @override
  State<MakeInvoice1> createState() => _MakeInvoice1State();
}

class _MakeInvoice1State extends State<MakeInvoice1> {
  List<bool> selection = <bool>[];
  Map prevData = {"cusName": []};

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    if (getData.getString("Customers") != null) {
      String dataString = await getData.getString("Customers")!;
      prevData = await jsonDecode(dataString);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            title: "MakeInvoice : Select Customer",
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
        body: ListView.builder(
            itemCount: prevData["cusName"].length,
            itemBuilder: (context, index) => Card(
                  color: Theme.of(context).secondaryHeaderColor,
                  child: ListTile(
                      title: Text("${prevData["cusName"][index]}"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MakeInvoice2(invoiceCusData: {
                                      "cusName": prevData["cusName"][index],
                                      "cusMNo": prevData["cusMNo"][index],
                                      "cusAd": prevData["cusAd"][index],
                                    })));
                      }),
                )));
  }
}
