import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sehetak2/consts/colors.dart';
import 'package:sehetak2/consts/symptoms.dart';

import 'package:sehetak2/models/symptom_model.dart';
import 'package:sehetak2/network/local/cache_helper.dart';
import 'package:sehetak2/network/remote/dio_helper.dart';
import 'package:sehetak2/network/remote/dio_token_getter.dart';
import 'package:sehetak2/packages/autocomplete_label.dart';


import '../../components/applocal.dart';
import 'intial_diagnosis_results.dart';

class DiagnosisTest extends StatefulWidget {
  int birthYear;
  String gender;

  DiagnosisTest(
    this.birthYear,
    this.gender
);
  @override
  State<DiagnosisTest> createState() => _DiagnosisTestState();
}

class _DiagnosisTestState extends State<DiagnosisTest> {

  List<Symptom> apiSymp;
  List<Symptom> selectedValues = [];
  //testSymptoms = dummy api data
  //symptoms = real api data
  List<Map<String, dynamic>> apiMap = [];
  double percentage = 0.5;
  bool isEnglish = true;


  TextEditingController controller=new TextEditingController();
  @override
  void initState() {

    // getSymps();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(isEnglish) {
      apiMap = symptoms;
    }
    else
      {
        apiMap = arabicSymptoms;
      }
    apiSymp = Symptom.fromListMap(apiMap);
    return Container(

      child: Scaffold(
        backgroundColor: ColorsConsts.primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170.0),
          child: AppBar(

            backgroundColor: ColorsConsts.primaryColor,
            // toolbarHeight: 65.0,
            title: Text(
                "${getLang(context,  "Symptom Specification")}"
                ),
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
                  Text(
                    "${getLang(context,  "Steps")}"
                    ,style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 15.0,),
                  Flexible(
                    child: LinearPercentIndicator(
                      animation: true,
                      lineHeight: 10.0,
                      animationDuration: percentage == 0.5 ? 1 : 1500,
                      animateFromLastPercent: true,
                      backgroundColor: Color(0xFFC4C4C4),
                      percent: percentage,
                      onAnimationEnd: (){
                        percentage = 1.0;
                        setState(() {
                        });
                      },
                      barRadius: Radius.circular(20.0),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Text(
                        "${getLang(context,  "Select Symptoms")}"
                        ,style: TextStyle(
                        color: Colors.white,
                      ),),
                      SizedBox(width: 60.0,),
                      Text("2/2",style: TextStyle(
                        color: Colors.white,
                      ),)

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 30.0,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, -4), // changes position of shadow
                      )
                    ],
                    gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Color(0xffe4f2f7), Colors.white]),
                    borderRadius: BorderRadius.only( topLeft: Radius.circular(50),topRight:Radius.circular(50) )
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: 50.0,),
                      // TagGenrator(tagList: tagList,fillRandomColor: true,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child:Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: AutocompleteLabel<String>(
                                    keepAutofocus: false,

                                    onChanged: (values) => selectedValues=values,
                                    autocompleteLabelController: AutocompleteLabelController<Symptom>(source:apiSymp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                            // Expanded(
                            //   child: TypeAheadField(
                            //     textFieldConfiguration: TextFieldConfiguration(
                            //       controller: controller,
                            //         autofocus: true,
                            //         style: TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 12.0,
                            //         ),
                            //         decoration: InputDecoration(
                            //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                            //         )
                            //     ),
                            //     suggestionsCallback: (pattern) async {
                            //       print(pattern);
                            //       return await search(pattern);
                            //     },
                            //     itemBuilder: (context, suggestion) {
                            //       return ListTile(
                            //         title: Text(suggestion,
                            //         style: TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 12.0,
                            //         ),),
                            //       );
                            //     },
                            //     onSuggestionSelected: (suggestion) {
                            //       print(suggestion.toString());
                            //       controller.text = suggestion;
                            //
                            //       selectedValues.add(suggestion);
                            //       setState(() {
                            //       });
                            //     },
                            //   ),
                            // ),
                      ),
                      SizedBox(height: 50.0,),

                      SizedBox(height: 30.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(

                            onChanged: (value){ isEnglish = value; setState(() {
                            }); },
                            value: isEnglish,
                          ),
                          Text("English",),
                        ],
                      ),
                      SizedBox(height: 30.0,),
                      TextButton(

                        onPressed: (){
                          if(selectedValues.isNotEmpty && selectedValues.length>=2) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DiagnosisResults(
                                        widget.birthYear, widget.gender,
                                        getAllIds(), getAllNames(), false, [])
                            ));
                          }
                          else if (selectedValues.length>=2)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${getLang(context,  "Please Select your Symptoms and try again")}"
                                 ,style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold
                                ),),
                              ));
                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${getLang(context,  "Please Select at least 2 symptoms")}"
                                  ,style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold
                                ),),
                              ));
                            }
                        },

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
                            "${getLang(context,  "Get Diagnosis")}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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

  List<String> getAllNames() {
    List<String> symptomsNames=[];
    for(Symptom symp in selectedValues)
      {
        symptomsNames.add(symp.name);
      }
    return symptomsNames;
  }
  List<int> getAllIds() {
    List<int> symptomsNames=[];
    for(Symptom symp in selectedValues)
    {
      symptomsNames.add(symp.id);
    }
    return symptomsNames;
  }
  void getSymptoms()
  {
    String token = CacheHelper.getData("tokenKey");
    if(token == null)
      {
        print("null");
        token=getToken();
        getApiData(token);
      }
    else
      {
        print("not null");
        getApiData(token);
      }
  }
  fromJsonToList(dynamic list)
  {

    for(int i=0;i<list.length;i++)
      {
        apiSymp.add(Symptom(name: list[i]['Name'],id: list[i]['ID']));
      }
    apiSymp.forEach((element) {
      print(element.name+" "+element.id.toString());
    });
  }
  String getToken()
  {
    String token="";
    DioTokenGetter.postData(url: "login",data: {
      "aaa" : "aaa"
    }
    ).then((value) {
      print(value.data);
      token = value.data['Token'];
      CacheHelper.putData("tokenKey", token);
      setState(() {});
      print("Data put in sp");

    }).catchError((error){
      print("error:"+error.response.toString());
    });
    return token;
  }
  void getSymps()
  {
    String sympString = CacheHelper.getData("symptomsKey");
    if(sympString == null)
      {
        print("Empty");
        String token = getToken();
        getApiSymptoms(token);
      }
    else {
      apiSymp = Symptom.decode(sympString);
    }
  }
  void getApiSymptoms(token)
  {
    DioHelper.getData(url: "symptoms",
        query: {
          'token':token,
          'format':'json',
          'language' :'en-gb'
        }).then((value) {
      print(value.data);
      apiSymp = Symptom.fromListMap(value.data);
      String encodedSymps = Symptom.encode(apiSymp);
      CacheHelper.putData("symptomsKey", encodedSymps);
      setState(() {});
    }).catchError((error)
    {
      print(error.response.toString());
    }
    );
  }
  // String getAccessToken()
  // {
  //   String token="";
  //   //fetch token
  //   DioTokenGetter.postData(url: "login",data: {
  //     "aaa" : "aaa"
  //   }
  //   ).then((value) {
  //     print(value.data);
  //     token = value.data['Token'];
  //   }).catchError((error) {print(error.toString());});
  //   return token;
  // }
  void getApiData(String token)
  {
    DioHelper.getData(url: "symptoms",
        query: {
          'token':token,
          'format':'json',
          'language' :'en-gb'
        }).then((value) {
      print(value.data);
      apiSymp = Symptom.fromListMap(value.data);
      setState(() {});
      // fromJsonToList(value.data);
      // print(apiSymp);
    }).catchError((error)
    {
      if(error.response.toString()=="Invalid token" || error.response.toString()=="Missing or invalid token")
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Token"),
        ));
        CacheHelper.delData("tokenKey");
        setState(() {});
        getSymptoms();
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("server error"),
        ));
      }
      print(error.response.toString());
    }
    );
  }
}
