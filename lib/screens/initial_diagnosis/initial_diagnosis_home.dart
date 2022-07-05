import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sehetak2/consts/colors.dart';
import 'package:sehetak2/network/remote/dio_token_getter.dart';
import 'package:sehetak2/screens/initial_diagnosis/intial_diagnosis_gender_age.dart';

import '../../components/applocal.dart';
import 'intial_diagnosis_history.dart';

class IntialDiagnisisHomeScreen extends StatefulWidget {


  @override
  State<IntialDiagnisisHomeScreen> createState() => _IntialDiagnisisHomeScreenState();
}

class _IntialDiagnisisHomeScreenState extends State<IntialDiagnisisHomeScreen> {

  bool hasConnection=false;
  bool isLoading=true;
  static String uid;

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await hasNetwork();
      getUserId();
      setState(() { });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Color(0xffe4f2f7), Colors.white]),

        ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: hasConnection ? [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context)
              {
                return ["Show Diagnosis History"].map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }
                ).toList();
              },
              onSelected: (item)
              {
                if(item == "Show Diagnosis History")
                {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DiagnosisHistory()));
                }
              },
              elevation: 20.0,
            ),
          ] : [],
          elevation: 5.0,
          backgroundColor: ColorsConsts.primaryColor,
          toolbarHeight: 65.0,
          title: Text(
              "${getLang(context, "Intial Diagnosis")}",),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
          ),
        ),
        body: ConditionalBuilder(
          condition: isLoading,
          builder: (builder) => Center(
            child: CircularProgressIndicator(color: Colors.blue,),
          ),
          fallback: (builder) => ConditionalBuilder(
          condition: hasConnection,
          builder: (build) => SafeArea(
          bottom: true,
          maintainBottomViewPadding: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Image.asset("assets/images/doctors-diagnosis.webp",),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text( "${getLang(context, "This Feature Takes your symptoms and tell you what diseases you could have and is your condition urgent or not.")}",),
              ),
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text( "${getLang(context, "NOTE! THIS DIAGNOSIS ISN'T 100% ACCURATE IF YOUR CONDITION IS CRITICAL OR YOU FEEL LIKE SOMTHING WRONG NOT MENTIONED IN THE DIAGNOSIS GO TO A REAL DOCTOR")}",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(

                  width: double.infinity,
                  child: TextButton(

                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IntialDiagnosisGenderAge()
                      ));},

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(ColorsConsts.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          )
                      ),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${getLang(context, "Start Diagnosis")}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
            ],
          ),
        ),
      fallback: (build) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/no_internet.png"),
            SizedBox(height: 5.0,),
            Text( "${getLang(context, "No network connection")}",
              style: TextStyle(
                  color: Color(0xFF8B96A7)
              ),),
            SizedBox(height: 5.0,),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${getLang(context, "Try Again")}",
                  style: TextStyle(
                      color: ColorsConsts.primaryColor
                  ),),
              ),
              onTap: (){
                setState(() {
                  isLoading = true;
                  hasNetwork().then((value) {
                    if(hasConnection) {
                      DioTokenGetter.getToken();
                      print("new token generated (was offline)");
                    }
                  });

                });

              },
            )
          ],
        ),
      ),
    ),),
        ),

      );

  }
  Future hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      hasConnection =  result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      print(hasConnection.toString());
    } on SocketException catch (_) {
      hasConnection = false;
    }
    isLoading = false;
    setState(() {});
  }

  void getUserId() {}
}
