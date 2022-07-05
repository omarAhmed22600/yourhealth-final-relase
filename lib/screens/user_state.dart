import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sehetak2/screens/dshbord-home/dashboard_home.dart';
import 'package:sehetak2/screens/landing_page.dart';
// import 'package:sehetak2/screens/bottom_bar.dart';
// import 'initial_diagnosis/initial_diagnosis_home.dart';

class UserState extends StatelessWidget {
  const UserState({Key key}) : super(key: key);
  static String userID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: missing_return
        builder: (context, userSnapShot) {
          if (userSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapShot.connectionState == ConnectionState.active) {
            if (userSnapShot.hasData) {
              userID = userSnapShot.data.uid;
              print(userID);
              print('the user is already active');
              return Dashboard();//BottomBarScreen()
            } else {
              print('the user is not  active');
              return const LandingPage();
            }
          } else if (userSnapShot.hasError) {
            return const Center(
              child: const Text('Error occured'),
            );
          }
        });
  }
}
