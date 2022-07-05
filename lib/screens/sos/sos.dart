import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../components/applocal.dart';

class showSos extends StatefulWidget {
  const showSos({Key key}) : super(key: key);

  @override
  State<showSos> createState() => _showSosState();
}

class _showSosState extends State<showSos> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/sos (2).png'),fit:BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
        title:  Text("SOS"),
        content:  Text("${getLang(context, "are you sure make emergency call?")}",),
        actions: [
          ElevatedButton(
            child:  Text("${getLang(context, "Yes")}",),
            onPressed: () {
              FlutterPhoneDirectCaller.callNumber("123");
              },
          ),
          ElevatedButton(
            child:  Text("${getLang(context, "No")}",),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          )
        ],
          ),
      ),
    );
  }
}
