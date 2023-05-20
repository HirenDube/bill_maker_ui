import 'package:bill_maker_ui/main.dart';
import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: "Introduction", bgColor: Theme.of(context).primaryColor),
      body: DefaultTabController(
        length: 3,
        child: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonBar(buttonPadding: EdgeInsets.all(10),children: [                TextButton(onPressed: (){}, child: Text("Skip"))
                ],),
                SizedBox(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height-300,
                  child: TabBarView(children: [
                    Center(
                      child: Text(
                        "Page 1 ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Page 2 ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Page 3 ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                ),
                TabPageSelector(
                  color: Theme.of(context).primaryColor,selectedColor: Colors.amber,indicatorSize: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
