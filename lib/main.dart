import "package:bill_maker_ui/HomeScreen.dart";
import "package:flutter/material.dart";

void main(){
  runApp(BillMakerApp());
}

class BillMakerApp extends StatelessWidget {
  const BillMakerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}


AppBar buildAppBar({required String title, Color bgColor = Colors.blue,leading = null,actions }){
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
    leading: leading,
    actions: actions,
  );
}