import 'package:bill_maker_ui/HomeScreen.dart';
import 'package:bill_maker_ui/Login.dart';
import 'package:bill_maker_ui/Register.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;

  @override
  void initState() {
    // TODO: implement initState
    lottieController =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..repeat(reverse: true);
    registartionVerfy();

    super.initState();
  }

  registartionVerfy() async {
    SharedPreferences navigate = await SharedPreferences.getInstance();
    if (navigate.getBool("Registered") != null) {
      if (navigate.getBool("Registered")!) {
        if (navigate.getBool("LoggedIn") != null) {
          if (navigate.getBool("LoggedIn")!) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              lottieController.dispose();
            });
          } else {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
              lottieController.dispose();
            });
          }
        } else {
          navigate.setBool("LoggedIn", false);
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
            lottieController.dispose();
          });
        }
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Registration()));
          lottieController.dispose();
        });
      }
    } else {
      navigate.setBool("Registered", false);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Registration()));
        lottieController.dispose();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Lottie.asset("assets/lotties/pay_bill.json",
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width - 200),
      )),
    );
  }
}
