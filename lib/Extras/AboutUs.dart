// ignore_for_file: file_names

import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
            title: "AboutUs", bgColor: Theme.of(context).primaryColor),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonBar(alignment: MainAxisAlignment.center, children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/github.png"),
                ),
                const Text("\nProject GitHub Link : "),
                TextButton(
                    onPressed: () async {
                      Uri source = Uri.parse(
                          "https://github.com/HirenDube/bill_maker_ui.git");
                      if (await canLaunchUrl(source)) {
                        launchUrl(source);
                      } else {
                        Fluttertoast.showToast(msg: "Can't launch url");
                      }
                    },
                    child:
                        const Text("https://github.com/HirenDube/bill_maker_ui.git"))
              ]),
              RichText(
                  text: TextSpan(
                      text: "Made by : ",
                      style: const TextStyle(color: Colors.black, fontSize: 25),
                      children: [
                    TextSpan(
                        text: "Divyang Gajera",
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor))
                  ])),
              RichText(
                  text: const TextSpan(
                      text: "For use only by : ",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      children: [
                    TextSpan(
                        text: "Small business owners",
                        style: TextStyle(fontSize: 20, color: Colors.blue))
                  ])),
              Column(
                children: [
                  ButtonBar(alignment: MainAxisAlignment.center, children: [
                    CircleAvatar(
                      child: Image.asset("assets/images/mail.jpg"),
                    ),
                    const Text("E-mail : "),
                    TextButton(
                        onPressed: () async {
                          Uri source = Uri.parse(
                              "mailto:extraac520@gmail.com?subject=Review%20Bill%20Maker%App=You%20App%20is%20great.%205/10%20stars%20from%20me");
                          if (await canLaunchUrl(source)) {
                            launchUrl(source);
                          } else {
                            Fluttertoast.showToast(msg: "Can't launch G-mail");
                          }
                        },
                        child: const Text("extraac520@gmail.com"))
                  ]),
                  ButtonBar(alignment: MainAxisAlignment.center, children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/instagram.jpg"),
                    ),
                    const Text("Instagram : "),
                    TextButton(
                        onPressed: () async {
                          Uri source = Uri.parse(
                              "https://www.instagram.com/dg_tech_news_01/");
                          if (await canLaunchUrl(source)) {
                            launchUrl(source);
                          } else {
                            Fluttertoast.showToast(msg: "Can't launch url");
                          }
                        },
                        child: const Text("@dg_tech_news_01"))
                  ]),
                  ButtonBar(alignment: MainAxisAlignment.center, children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/images/WebApp.png"),
                    ),
                    const Text("Web App : "),
                    TextButton(
                        onPressed: () async {
                          Uri source =
                              Uri.parse("https://bill-maker-ui.web.app/#/");
                          if (await canLaunchUrl(source)) {
                            launchUrl(source);
                          } else {
                            Fluttertoast.showToast(msg: "Can't launch url");
                          }
                        },
                        child: const Text("https://bill-maker-ui.web.app/#/"))
                  ]),
                ],
              )
            ],
          ),
        ));
  }
}
