import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehetak2/screens/user_state.dart';


class splashpage extends StatefulWidget {
  const splashpage({Key key}) : super(key: key);

  @override
  _splashpageState createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      CheckSignedIn();
    });
  }
  void CheckSignedIn() async {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>UserState()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/صحتك99.png",
              width: 700,
              height: 700,
            ),
          ],
        ),
      ),
    );
  }
}
