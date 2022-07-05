import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sehetak2/screens/bottom_bar.dart';
import 'package:sehetak2/screens/components%20drawer/contact.dart';
import 'package:sehetak2/screens/components%20drawer/setting.dart';
import 'package:sehetak2/screens/medicine-remminder/screens/home/home.dart';
import 'package:sehetak2/screens/pediatric/pediatric-home.dart';
import 'package:sehetak2/screens/sos/sos.dart';
import 'package:sehetak2/widget/OnlineConsultation.dart';
import 'package:sehetak2/widget/clinic-examination.dart';
import 'package:sehetak2/screens/user_info.dart';
import 'package:sehetak2/widget/dashboard.dart';
import 'package:sehetak2/widget/home-examination.dart';

import '../../components/applocal.dart';
import '../initial_diagnosis/initial_diagnosis_home.dart';

class Dashboard extends StatefulWidget {
  static String uid;
  static String name;
  static String email;
  static String joinedAt;
  static String userImageUrl;
  static int phoneNumber;
  static String token;
  Dashboard();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int currentIndex = 1;
  String _uid;
  List<Widget> screens = [
    UserInfoS(),
    DashboardTab(),
    SettingsPage(),
  ];


  @override
  void initState() {
    initializeData();
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${getLang(context, "Exit App")}",),
        content: Text("${getLang(context, "Do you want to exit an App?")}",),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text("${getLang(context, "No")}",),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:Text("${getLang(context, "Yes")}",),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Scaffold(
          backgroundColor: HexColor("#f5fcfd"),
          appBar: AppBar(
            backgroundColor: HexColor("#80B1FE"),
            title: Center(
              child: Text("${getLang(context, "YourHealth app")}",),
            ),
          ),
          body: screens[currentIndex],
          bottomNavigationBar: new BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            backgroundColor: HexColor("#f5fcfd"),
            items: [
              new BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                label: "${getLang(context, "Profile")}",
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: "${getLang(context, "Home")}",
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.settings),
                label: "${getLang(context, "Settings")}",
              ),
            ],
          ),
        ),
      )
    );
  }

  void initializeData() async {
    User user=_auth.currentUser;
    Dashboard.uid = user.uid;
    final DocumentSnapshot userDocument = user.isAnonymous ? null
        : await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    if(userDocument == null){
      return;
    }
    else
    {
      setState(() {
        Dashboard.name = userDocument.get('name');
        Dashboard.email = user.email;
        Dashboard.phoneNumber = userDocument.get('phoneNumber');
        Dashboard.joinedAt = userDocument.get('joinedAt');
        Dashboard.userImageUrl = userDocument.get('imageUrl');
        Dashboard.token = userDocument.get("token");
      });
    }
  }

}




class NavDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            margin:  EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(Dashboard.userImageUrl != null ? Dashboard.userImageUrl : "",),
                ),

                Expanded(
                  child: Text(Dashboard.name != null ? Dashboard.name : "User",style:
                  const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),),
                ),
                Expanded(
                  child: Text(Dashboard.phoneNumber != null ? "0"+Dashboard.phoneNumber.toString() : "Phone Number",style:
                  TextStyle(fontSize: 12,color: Colors.grey[600]),),
                )
              ],
            ),
          ),

          ListTile(
            leading:  Image.asset("assets/lottie/setting.png"),
            title: Text("${getLang(context, "Settings")}",style: TextStyle(color: HexColor("#807C7C")),),
            onTap:  (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsPage()));
            },
          ),
          ListTile(
            leading: Image.asset("assets/lottie/Group.png"),
            title: Text("${getLang(context, "Feedback & Contact us")}",style: TextStyle(color: HexColor("#807C7C")),),
            onTap:  (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Contact()));
              },
          ),
          Divider(
            color: HexColor("#E5E5E9"),
          ),
          ListTile(
            leading: Image.asset("assets/lottie/Logout.png"),
            title: Text("${getLang(context, "Sign out")}",style: TextStyle(color: HexColor("#807C7C")),),
            onTap: () async {
            //  await _auth.signOut().then((value) {
            // Navigator.pop(context);
            // });
            },
          ),
        ],
      ),
    );
  }
}