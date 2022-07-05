
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sehetak2/screens/chat/Services/database.dart';
import 'package:sehetak2/screens/chat/VIews/recchat.dart';
import 'package:sehetak2/screens/chat/helperfunctions/shardpref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status{
  uninitalized,
  authenticated,
  authenticating,
  authenticateErorr,
  authenticatecannceled,
}

class AuthMethods {
  final GoogleSignIn googleSignIn;
   final FirebaseAuth firebaseAuth;
   final SharedPreferences Prefs;
  Status  _status=Status.uninitalized;

  Status get status =>_status;

  AuthMethods({
     this.firebaseAuth,
     this.googleSignIn,
     this.Prefs,
  });
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
    await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result =
    await _firebaseAuth.signInWithCredential(credential);

    User userDetails = result.user;

    if (result != null) {
      SharedPreferenceHelper().saveUserEmail(userDetails.email);
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper()
          .saveUserName(userDetails.email.replaceAll("@gmail.com", ""));
      SharedPreferenceHelper().saveDisplayName(userDetails.displayName);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);

      Map<String, dynamic> userInfoMap = {
        "email": userDetails.email,
        "username": userDetails.email.replaceAll("@gmail.com", ""),
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL
      };

      DatabaseMethods()
          .addUserInfoToDB(userDetails.uid, userInfoMap)
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const recchat()));
      });
    }
  }

  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut();
  }
  Future<void>handleSingOut() async{
    _status=Status.uninitalized;
    await googleSignIn.disconnect();
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
