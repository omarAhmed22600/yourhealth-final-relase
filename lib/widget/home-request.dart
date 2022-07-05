import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sehetak2/screens/dshbord-home/dashboard_home.dart';
import 'package:sehetak2/widget/dashboard.dart';

import 'home-examination.dart';

GlobalKey<FormState> formstate = new GlobalKey<FormState>();
var name, phone, location;

CollectionReference homereq = FirebaseFirestore.instance.collection("home");
var _controller = TextEditingController();
var _controller2 = TextEditingController();
var _controller3 = TextEditingController();

class HomeRequest extends StatelessWidget {
  const HomeRequest({Key key}) : super(key: key);

  requestHome() async {
    var formdata = formstate.currentState;

    if (formdata.validate()) {
      formdata.save();

      await homereq.add({
        "name": name,
        "number": phone,
        "location": location,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Scaffold(
            backgroundColor: HexColor("#f5fcfd"),
            body: Form(
              key: formstate,
              child: Column(
                children: [
                  Row(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 35.h,
                          left: 14.w,
                        ),
                        child: InkWell(
                          child: Icon(Icons.arrow_back_ios_rounded,
                              size: 18.0, color: HexColor('#787575')),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 33.h,
                        left: 5.w,
                      ),
                      child: Text(
                        'Home Examination',
                        style: TextStyle(
                          color: HexColor('#333333'),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    height: 187.h,
                    width: 160.w,
                    child: CircleAvatar(
                      radius: 48,
                      // Image radius
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-vector/medical-appointment-therapist-house-call-vector-illustration-cartoon-woman-doctor-visiting-sick-man-patient-examination-healthcare-service-call-family-doctor-home-isolated-white_212168-1192.jpg?w=2000'),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    height: 65.h,
                    child: TextFormField(
                      controller: _controller3,
                      validator: (val) {
                        if (val.length > 20) {
                          return "name can't be larger than 20 letter";
                        }
                        if (val.length < 3) {
                          return "name can't be less than 3 letter";
                        }
                      },
                      onSaved: (value) {
                        name = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: IconButton(
                          onPressed: _controller3.clear,
                          icon: Icon(Icons.clear),
                        ),
                        border: InputBorder.none,
                        labelText: 'Enter Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5.w,
                      left: 5.w,
                    ),
                    child: const Divider(
                      height: 10,
                      thickness: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.h,
                    ),
                    child: Container(
                      height: 65.h,
                      child: TextFormField(
                        controller: _controller2,
                        validator: (val) {
                          if (val.length > 11) {
                            return "number can't be larger than 11 numbers";
                          }
                          if (val.length < 11) {
                            return "name can't be less than 11 numbers";
                          }
                        },
                        onSaved: (val) {
                          phone = val;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          suffixIcon: IconButton(
                            onPressed: _controller2.clear,
                            icon: Icon(Icons.clear),
                          ),
                          border: InputBorder.none,
                          labelText: 'Add Phone Number',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5.w,
                      left: 5.w,
                      top: 5.h,
                    ),
                    child: Divider(
                      height: 10,
                      thickness: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.h,
                    ),
                    child: Container(
                      height: 65.h,
                      child: TextFormField(
                        controller: _controller,
                        validator: (val) {
                          if (val.length > 30) {
                            return "location can't be larger than 20 letter";
                          }
                          if (val.length < 5) {
                            return "name can't be less than 5 letter";
                          }
                        },
                        onSaved: (value) {
                          location = value;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          suffixIcon: IconButton(
                            onPressed: _controller.clear,
                            icon: Icon(Icons.clear),
                          ),
                          border: InputBorder.none,
                          labelText: 'Enter The Location',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5.w,
                      left: 5.w,
                      top: 5.h,
                    ),
                    child: const Divider(
                      height: 10,
                      thickness: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 96.h,
                    ),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 231, height: 44),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#80B1FE'),
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Text('Confirm'),
                        onPressed: () async {
                          await requestHome();
                          showAlertDialog(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  void showAlertDialog(BuildContext context) {
    Widget remindButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeExamination(DashboardTab.name,DashboardTab.userImageUrl);
        }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content:
          Text("your request is confirmed the doctor will talk to you soon"),
      actions: [
        remindButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
