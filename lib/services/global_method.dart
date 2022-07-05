import 'package:flutter/material.dart';

class GlobalMethods {
  Future<void> showDialogg(
      String title, String subtitle, Function fct, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
            
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    fct();
                    Navigator.pop(context);
                  },
                  child: const Text('ok'))
            ],
          );
        });
  }

  Future<void> authErrorhandler(String subtitle, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
            
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('error occured'),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [
              
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok'))
            ],
          );
        });
  }
}
