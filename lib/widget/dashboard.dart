import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sehetak2/components/applocal.dart';
import 'package:sehetak2/screens/initial_diagnosis/initial_diagnosis_home.dart';

import '../screens/bottom_bar.dart';
import '../screens/dshbord-home/dashboard_home.dart';
import '../screens/medicine-remminder/screens/home/home.dart';
import '../screens/pediatric/pediatric-home.dart';
import '../screens/sos/sos.dart';
import 'OnlineConsultation.dart';
import 'clinic-examination.dart';
import 'home-examination.dart';

class DashboardTab extends StatefulWidget {
  static String uid;
  static String name;
  static String email;
  static String joinedAt;
  static String userImageUrl;
  static int phoneNumber;
  static String token;

  DashboardTab();

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid;
String _name;
String _email;
String _joinedAt;
String _userImageUrl;
int _phoneNumber;
String _token;
@override
  void initState() {
    super.initState();
    setState(() {});
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Image.network(
              "https://img.freepik.com/free-photo/medical-team-doctor-hospital_33807-711.jpg?w=2000"),
          fit: BoxFit.fill,
        ),
        SizedBox(height: 60.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            children: [
              Column(
                children: [
                   Text(
                    "${getLang(context, "Welcome To Your Health")}",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black,),
                  ),
                  Text(
                    _name == null ? "Guest" : _name,
                    style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(_userImageUrl ?? "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                  ) ,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 60.h,
            left: 22.w,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Card(
                  color: HexColor("#80B1FE"),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomBarScreen()));
                    },
                    child: Container(
                      width: 180.w,
                      height: 250.h,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 30.h,
                          left: 10.w,
                        ),
                        child: Column(children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.medication_liquid_outlined,
                              color: HexColor("#FFFFFF"),
                              size: 50,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 30.h,
                              left: 4.w,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${getLang(context, "Want to buy a product?")}",
                                style: TextStyle(
                                  color: HexColor('#FFFFFF'),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.h,
                              left: 0.w,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${getLang(context, "Check  our \n online pharmacy")}",
                                style: TextStyle(
                                  color: HexColor('#FFFFFF'),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Card(
                    color: HexColor("#80B1FE"),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OnlineConsultation(_name,_userImageUrl)));
                      },
                      child: Container(
                        width: 180.w,
                        height: 250.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 10.w,
                          ),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.chat,
                                color: HexColor("#FFFFFF"),
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                left: 4.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Want to take an advice online?")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Book an online \n consultation")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Card(
                    color: HexColor("#80B1FE"),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ClinicExamination(_name,_userImageUrl)));
                      },
                      child: Container(
                        width: 180.w,
                        height: 250.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 10.w,
                          ),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.local_hospital,
                                color: HexColor("#FFFFFF"),
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                left: 4.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Want to take make a clinic appointment?")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Book a clinic \n examination")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Card(
                    color: HexColor("#80B1FE"),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeExamination(_name,_userImageUrl)));
                      },
                      child: Container(
                        width: 180.w,
                        height: 250.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 10.w,
                          ),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.home_filled,
                                color: HexColor("#FFFFFF"),
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                left: 4.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Want to get home appointment?")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Book a home \n examination")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Card(
                    color: HexColor("#80B1FE"),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>IntialDiagnisisHomeScreen()));
                      },
                      child: Container(
                        width: 180.w,
                        height: 250.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 10.w,
                          ),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.list_alt,
                                color: HexColor("#FFFFFF"),
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                left: 4.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Want to get initial diagnosis?")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Check our \n initial diagnosis")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Card(
                    color: HexColor("#80B1FE"),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const showSos()));

                      },
                      child: Container(
                        width: 180.w,
                        height: 250.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 10.w,
                          ),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.only(left: 7.0),
                                width: 55,
                                  height: 55,
                                  child: Image.asset("assets/images/img_1.png",)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                left: 4.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Want to make a SOS call?")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Check our \n SOS")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Card(
                    color: HexColor("#80B1FE"),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeReminder()));
                      },
                      child: Container(
                        width: 180.w,
                        height: 250.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 10.w,
                          ),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.alarm,
                                color: HexColor("#FFFFFF"),
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                left: 4.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Want to set a medicine alarm?")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Check our\nmedicine reminder")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Card(
                    color: HexColor("#80B1FE"),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MakeDashboardItems()));
                      },
                      child: Container(
                        width: 180.w,
                        height: 250.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                            left: 10.w,
                          ),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.medication_outlined,
                                color: HexColor("#FFFFFF"),
                                size: 50,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                left: 4.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Want to know the possible dose for your child?")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                left: 0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${getLang(context, "Check our \n pediatric dose")}",
                                  style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

  void getData() async {
    User user=_auth.currentUser;
    _uid = user.uid;
    final DocumentSnapshot userDocument = user.isAnonymous ? null
        : await FirebaseFirestore.instance.collection("users").doc(_uid).get();
    if(userDocument == null){
      return;
    }
    else
    {
      setState(() {
        _name = userDocument.get('name');
        _email = user.email;
        _phoneNumber = userDocument.get('phoneNumber');
        _joinedAt = userDocument.get('joinedAt');
        _userImageUrl = userDocument.get('imageUrl');
        _token = userDocument.get("token");

        DashboardTab.name = _name;
        DashboardTab.email = _email;
        DashboardTab.userImageUrl = _userImageUrl;
        DashboardTab.uid = _uid;
        DashboardTab.token = _token;
        DashboardTab.joinedAt = _joinedAt;
        DashboardTab.phoneNumber = _phoneNumber;
      });
    }
  }

}
