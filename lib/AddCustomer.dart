import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "AddCustomer", bgColor: Theme.of(context).primaryColor),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          width: MediaQuery.of(context).size.width - 50,
          child: ListView(
            children: [
              TextFormField(
                onChanged: (value) {},
                validator: (value) {},
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
                onChanged: (value) {},
                validator: (value) {},
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
                onChanged: (value) {},
                validator: (value) {},
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
              TextFormField(
                onChanged: (value) {},
                validator: (value) {},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    labelText: "Customer's GST No. :",
                    hintText: "Enter Customer's GST No. here...",
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              Divider(
                color: Colors.transparent,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    " Add ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
