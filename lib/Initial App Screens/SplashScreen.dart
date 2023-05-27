// ignore_for_file: file_names

import 'package:bill_maker_ui/Initial%20App%20Screens/HomeScreen.dart';
import 'package:bill_maker_ui/Initial%20App%20Screens/Login.dart';
import 'package:bill_maker_ui/Initial%20App%20Screens/Register.dart';
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
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
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
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
              lottieController.dispose();
            });
          } else {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()));
              lottieController.dispose();
            });
          }
        } else {
          navigate.setBool("LoggedIn", false);
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Login()));
            lottieController.dispose();
          });
        }
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Registration()));
          lottieController.dispose();
        });
      }
    } else {
      navigate.setBool("Registered", false);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Registration()));
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
