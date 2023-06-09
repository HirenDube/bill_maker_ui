import 'package:bill_maker_ui/Initial%20App%20Screens/SplashScreen.dart';
import "package:flutter/material.dart";

void main() {
  runApp(const BillMakerApp());
}

class BillMakerApp extends StatelessWidget {
  const BillMakerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white,),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width - 50, 40),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
          primaryColor: const Color(0xFF4300C1)),
      home: const SplashScreen(),
    );
  }
}

AppBar buildAppBar(
    {required String title,
    Color bgColor = Colors.blue,
    leading,
    actions}) {
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
    leading: leading,
    actions: actions,
  );
}
