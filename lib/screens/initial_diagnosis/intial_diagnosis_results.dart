import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sehetak2/consts/colors.dart';
import 'package:sehetak2/models/diagnosis_results_chars_model.dart';
import 'package:sehetak2/models/diagnosis_results_model.dart';
import 'package:sehetak2/models/symptom_model.dart';
import 'package:sehetak2/network/remote/dio_helper.dart';
import 'package:sehetak2/network/remote/dio_token_getter.dart';
import 'package:sehetak2/screens/dshbord-home/dashboard_home.dart';
import 'package:sehetak2/screens/initial_diagnosis/initial_diagnosis_see_more.dart';
import 'package:sehetak2/screens/initial_diagnosis/intial_diagnosis_history.dart';
import 'package:sehetak2/screens/user_info.dart';
import 'package:sehetak2/screens/user_state.dart';
import 'package:sehetak2/widget/OnlineConsultation.dart';
import 'package:sehetak2/widget/dashboard.dart';

import '../../components/applocal.dart';

class DiagnosisResults extends StatefulWidget {
  int birthYear;
  String gender;
  List<int> selectedSymptoms;
  List<dynamic> symptomsNames;
  bool fromHistory;
  List<DiagnosisResult> historyDiseases = [];
  DiagnosisResults(this.birthYear,this.gender,this.selectedSymptoms,this.symptomsNames,this.fromHistory,this.historyDiseases);

  @override
  _DiagnosisResultsState createState() => _DiagnosisResultsState();
}

class _DiagnosisResultsState extends State<DiagnosisResults> {
  List<DiagnosisResult> diseases = [];
  Map<String,DiagnosisChars> diseasesDis;
  bool isDataLoaded = false;
  int expandedIndex = -1;
  DiagnosisChars seeMore;

  @override
  void initState() {
    if(!widget.fromHistory)
      {
        getDiagnosisResults();
      }
    else
      {
        diseases = widget.historyDiseases;
        isDataLoaded = true;
      }

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
          elevation: 5.0,
          backgroundColor: ColorsConsts.primaryColor,
          toolbarHeight: 65.0,
          title: Center(child: Text("Intial Diagnosis"
          )),
          actions: [
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
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: ConditionalBuilder(
          condition: isDataLoaded,
          builder:(build) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.0,),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      Text("Your Information"),
                      SizedBox(width: 5.0,),
                      Expanded(
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Gender :',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black
                        ),),
                      SizedBox(width: 10.0,),
                      Icon(
                        widget.gender.toLowerCase() == "male" ?
                            Icons.male : Icons.female,
                        color: ColorsConsts.primaryColor,
                      ),
                      Text(widget.gender,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: ColorsConsts.primaryColor
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Age :',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black
                        ),),
                      SizedBox(width: 10.0,),
                      Text((DateTime.now().year - widget.birthYear).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: ColorsConsts.primaryColor
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Symptoms :',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black
                        ),),
                      SizedBox(width: 10.0,),
                      Flexible(
                        child: Text(buildSympNames(widget.symptomsNames),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: ColorsConsts.primaryColor
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      Text("Your Results"),
                      SizedBox(width: 5.0,),
                      Expanded(
                        child: Divider(
                          thickness: 2.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  // buildDiseaseItem(0),
                  ConditionalBuilder(condition: diseases.isEmpty,
                      builder: (build) => Center(
                        child: Column(
                          children: [
                            Image(
                              height: 100,
                              width: 100,
                              image: AssetImage("assets/images/no_result_found.png",),
                            ),
                            SizedBox(height: 10.0,),
                            Text("No disease found for the selected symptoms",style: TextStyle(
                                color: Color(0xFF8B96A7),

                            ),
                            textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    fallback: (build) => ListView.separated(itemBuilder: (context,index) => buildDiseaseItem(index),
                      itemCount: diseases.length,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context,index) => SizedBox(height: 25.0,),
                      shrinkWrap: true,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextButton(

                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OnlineConsultation(DashboardTab.name,DashboardTab.userImageUrl)));
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
                        "${getLang(context,  "Get Doctor's consult")}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ),
                  SizedBox(height: 20.0,),

                ],

              ),
            ),
          ),
          fallback:(build) => Center(
            child: CircularProgressIndicator(color: Colors.blue,),
          ),
        ),
      ),
    );
  }
  void getDiagnosisResults()
  {
    DioHelper.getData(url: "diagnosis", query: {
      "symptoms" : widget.selectedSymptoms.toString(),
      "gender" : widget.gender.toLowerCase(),
      "year_of_birth" : widget.birthYear,
      "token" : DioTokenGetter.token,
      "language" : "en-gb"
    }).then((value) {
      diseases = DiagnosisResult.fromListMap(value.data);
      if(diseases.isNotEmpty) {
        getUploadData(value.data);
      }
      isDataLoaded = true;
      setState(() {});
      print(getAllNames(diseases).toString());
    }).catchError((error){
      print(error);
    });
  }
  Future getDiseaseDiscription(int diseaseId,int index)
  async {
    await DioHelper.getData(url: "issues/${diseaseId.toString()}/info", query: {
      "token" : DioTokenGetter.token,
      "language" : "en-gb"
    }).then((value) {
       print(value.data);
       // diseasesDis.insert(index,DiagnosisChars.fromJson(value.data));
       // diseasesDis.putIfAbsent("${diseases[index].disease.id}", () => null);
      seeMore = DiagnosisChars.fromJson(value.data);

    }).catchError((error){
      print(error);
    });
  }
  List<String> getAllNames(List<DiagnosisResult> results ) {
    List<String> diseaseName=[];
    for(DiagnosisResult res in results)
    {
      diseaseName.add(res.disease.name);
    }
    return diseaseName;
  }
  String buildSympNames(List<dynamic> symptoms)
  {
    String symptomsString = "";
    symptomsString = symptoms.join("\n");
    return symptomsString;
  }
  getUploadData(List<dynamic> diagnosis) async
  {
    CollectionReference ref = FirebaseFirestore.instance.collection("diagnosis");
    ref.add({
      "date" : DateTime.now().year.toString() +"-" + DateTime.now().month.toString() + "-" + DateTime.now().day.toString(),
      "userID" : UserState.userID,
      "symptoms" : widget.symptomsNames,
      "gender" : widget.gender,
      "birthYear" : widget.birthYear,
      "diagnosisInfo" : diagnosis,
      "time" : DateTime.now().hour.toString()+":"+DateTime.now().minute.toString()+":"+DateTime.now().second.toString(),
    });

  }
  Widget buildDiseaseItem(index)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: ColorsConsts.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0,),
              Text(
                index != null ? diseases[index].disease.name : "Loading...",
                style: TextStyle(
                    color: ColorsConsts.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                children: [
                  Text(
                    "${getLang(context, "Possibility:")}",
                    style: TextStyle(
                        color: ColorsConsts.blueText,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 2.0,),
                  LinearPercentIndicator(
                    animation: true,
                    width: 180.0,
                    lineHeight: 10.0,
                    animationDuration: 2500,
                    percent: diseases[index].disease.accuracy/100.round(),
                    barRadius: Radius.circular(20.0),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: diseases[index].disease.accuracy.round() < 25 ? ColorsConsts.under_25_Color :
                    diseases[index].disease.accuracy.round() < 50 ? ColorsConsts.greater_25_Color :
                    diseases[index].disease.accuracy.round() < 75 ? ColorsConsts.greater_50_Color :
                    diseases[index].disease.accuracy.round() < 90 ? ColorsConsts.greater_75_Color :
                    diseases[index].disease.accuracy.round() < 100 ? ColorsConsts.under_100_Color : Colors.white,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 2.0,),
                  Expanded(
                    child: Text(
                      diseases[index].disease.accuracy.round().toString()+"%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: ColorsConsts.blueText,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'ICD Code:',
                    style: TextStyle(
                        color: ColorsConsts.blueText,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  Expanded(
                    child: Text(
                      diseases[index].disease.icd.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Center(
                heightFactor: 0.4,
                child: InkWell(
                  onTap: (){
                          getDiseaseDiscription(diseases[index].disease.id,index).then((value) {
                            Navigator.of(context).push(MaterialPageRoute(//diseasesDis['${diseases[index].disease.id
                                builder: (context) => ResultSeeMore(diseases[index] , seeMore)
                            ));
                          });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${getLang(context,  "Learn More")}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
            ],
          ),
        ),
      ),
    );
  }
}

