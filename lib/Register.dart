import 'package:bill_maker_ui/Login.dart';
import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String abc = 'initial commit pusshed';

  GlobalKey<FormFieldState> _userKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _passKey = GlobalKey<FormFieldState>();

  String? username, password;
  List<String> uname = [];
  List<String> pname = [];

  var success = "black";

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final getData = await SharedPreferences.getInstance();
    final uls = getData.getStringList("Users");
    final pls = getData.getStringList("Passes");

    uname = uls! ?? uname;
    pname = pls! ?? pname;
    // print(pname);
    // print(uname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: "User Registration ",
        // title: "User Login ${uname} : ${pname}",
        bgColor: Colors.teal,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop),
                fit: BoxFit.fill,
                image: AssetImage("assets/images/bill_ui_bg(1).jpg"))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height - 400,
          width: MediaQuery.of(context).size.width - 100,
          child: ListView(
            children: [
              TextFormField(
                onChanged: (value) {
                  username = value;
                },
                key: _userKey,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Username : ",
                    floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    fillColor: Colors.white,
                    filled: true),
                validator: (username1) {
                  if (username1!.isNotEmpty) {
                    return null;
                  } else {
                    return "Username can't be empty !!";
                  }
                },
              ),
              Divider(
                color: Colors.transparent,
              ),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                key: _passKey,
                decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Password : ",
                    fillColor: Colors.white,
                    filled: true),
                validator: (password1) {
                  if (password1!.isEmpty) {
                    return "Password can't be empty !!";
                  } else if (!password1.contains(RegExp(r'\d'))) {
                    return "Password should contain at least one number !!";
                  } else if (!password1.contains(RegExp(r'^(.*[a-z])'))) {
                    return "Password should contain at least one Small Alphabet !!";
                  } else if (!password1.contains(RegExp(r'^.*[A-Z]'))) {
                    return "Password should contain at least one Capital Alphabet !!";
                  } else if (!password1.contains(RegExp(r'[!@#$%^&*()_+]'))) {
                    return "Password should contain atleast one Special Character !!";
                  } else {
                    return null;
                  }
                },
              ),
              Divider(
                color: Colors.transparent,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () async {
                    if (_userKey.currentState!.validate() &&
                        _passKey.currentState!.validate()) {
                      final dataEntry = await SharedPreferences.getInstance();
                      setState(() {
                        uname.add(username!);
                        pname.add(password!);
                        dataEntry.setStringList("Users", uname);
                        dataEntry.setStringList("Passes", pname);
                        success = "white";
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }
                  },
                  child: Text("SUBMIT ${success}"))
            ],
          ),
        ),
      ),
    );
  }
}