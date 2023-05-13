import 'package:bill_maker_ui/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
      lottieController.dispose();
    });
    super.initState();
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
