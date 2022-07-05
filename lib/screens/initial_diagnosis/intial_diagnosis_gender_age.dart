import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sehetak2/consts/colors.dart';

import '../../components/applocal.dart';
import 'intial_diagnosis_test.dart';

class IntialDiagnosisGenderAge extends StatefulWidget {
  @override
  State<IntialDiagnosisGenderAge> createState() => _IntialDiagnosisGenderAgeState();
}

class _IntialDiagnosisGenderAgeState extends State<IntialDiagnosisGenderAge> {
  String gender="Male";
  int age = 17;
  List<int> data= [];


  @override
  void initState() {
    super.initState();
    data=buildAge();
  }
  @override
  Widget build(BuildContext context) {
    double percent;
    return Container(
      decoration: BoxDecoration(

      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170.0),
          child: AppBar(
            // elevation: 5.0,
            backgroundColor: ColorsConsts.primaryColor,
            // toolbarHeight: 150.0,
            title: Text("${getLang(context, "Gender and Age")}",),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0),
              ),
            ),
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100.0,),
                  Text("${getLang(context, "Steps")}", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 15.0,),
                  Flexible(
                    child: LinearPercentIndicator(
                      animation: true,
                      lineHeight: 10.0,
                      animationDuration: 1500,
                      animateFromLastPercent: true,
                      backgroundColor: Color(0xFFC4C4C4),
                      percent: 0.5,
                      // onAnimationEnd: (){
                      //   percentage = 1.0;
                      //   setState(() {
                      //   });
                      // },
                      barRadius: Radius.circular(20.0),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Text("${getLang(context, "Select Age and Gender")}",style: TextStyle(
                        color: Colors.white,
                      ),),
                      SizedBox(width: 60.0,),
                      Text("1/2",style: TextStyle(
                          color: Colors.white,
                      ),)

                    ],
                  ),
                ],
              ),
            ),
            // bottom: PreferredSize(
            //   preferredSize: Size.fromHeight(4.0),
            //   child: ,
            // ),
          ),
        ),
        backgroundColor: ColorsConsts.primaryColor,
        body: Column(
          children: [
            SizedBox(height: 30.0,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, -4), // changes position of shadow
              )
                ],
                    gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Color(0xffe4f2f7), Colors.white]),
                  borderRadius: BorderRadius.only( topLeft: Radius.circular(50),topRight:Radius.circular(50) )
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.0,),
                      Center(
                        child: Text(
                          "${getLang(context, "Select Your Gender")}",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      SizedBox(height: 20.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: GenderPickerWithImage(
                          isCircular: true,
                          femaleText: "${getLang(context, "Female")}",
                          maleText: "${getLang(context, "Male")}",
                          verticalAlignedText: true,
                          linearGradient: LinearGradient(
                              colors: [ColorsConsts.primaryColor, ColorsConsts.primaryColor], ),
                          selectedGender: Gender.Male,
                          onChanged: (gender)
                          {
                            switch (gender)
                            {
                              case Gender.Male:
                                this.gender = "Male";
                                break;
                              default:
                                this.gender = "Female";
                                break;
                            }
                          },
                          opacityOfGradient: 0.4,

                          selectedGenderTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsConsts.primaryColor
                          ),
                          unSelectedGenderTextStyle: TextStyle(
                              color:Colors.black54 , ),
                          animationDuration: Duration(milliseconds: 500),
                          size: 150.0,

                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Center(
                        child: Text(
                          "${getLang(context, "Select Your Age")}",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(

                          image: DecorationImage(image: AssetImage("assets/images/slider_design.png") as ImageProvider)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: ScrollSnapList(
                            itemBuilder: _buildItemList,
                            itemSize: 80,
                            dynamicItemSize: true,
                            duration: 300,
                            initialIndex: 16,
                            onItemFocus: (index)
                            {
                              print(index);
                              age = data[index];
                            },
                            onReachEnd: (){
                              print('Done!');
                            },
                            itemCount: data.length,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: SizedBox(

                          width: double.infinity,
                          child: TextButton(

                            onPressed: (){
                              int birthYear= DateTime.now().year - age;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DiagnosisTest(birthYear,gender)
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
                                "${getLang(context, "Confirm")}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(BuildContext context, int index){
    double fontSize;
    Color color ;
    FontWeight weight;
    if(index == data.length)
      return Center(
        child: CircularProgressIndicator(),
      );
    if(index+1 == age)
      {
        fontSize=37.0;
        color=ColorsConsts.primaryColor;
        weight=FontWeight.bold;
        // return Container(
        //   width: 80,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         child: Center(
        //           child: Text('${data[index]}',style: TextStyle(fontSize: 50.0,color: ColorsConsts.primaryColor,fontWeight: FontWeight.bold),),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      }

    else if(index+1 > age+1 || index+1 < age-1)
      {
        fontSize = 25.0;
        color = Colors.grey;
        weight = FontWeight.normal;
        // return Container(
        //   width: 80,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         child: Center(
        //           child: Text('${data[index]}',style: TextStyle(fontSize: 25.0,color: Colors.grey,fontWeight: FontWeight.normal),),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      }
    else
      {
        fontSize = 30.0;
        color = Colors.black;
        weight = FontWeight.normal;
      }
      return Container(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text('${data[index]}',style: TextStyle(fontSize: fontSize,color: color,fontWeight: weight),),
              ),
            ),
          ],
        ),
      );
  }

  List<int> buildAge()
  {
    List<int> ages = [];
    for(int i = 1;i<=100;i++)
      {
        ages.add(i);
      }
    return ages;
  }



}
