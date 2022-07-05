import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sehetak2/consts/colors.dart';
import 'package:sehetak2/models/diagnosis_results_chars_model.dart';
import 'package:sehetak2/models/diagnosis_results_model.dart';
import 'package:sehetak2/screens/initial_diagnosis/intial_diagnosis_results.dart';

import '../../components/applocal.dart';

class ResultSeeMore extends StatefulWidget {
  DiagnosisResult selecetedDisease;
  DiagnosisChars selecetedDiseaseDescribtion;
  ResultSeeMore(this.selecetedDisease,this.selecetedDiseaseDescribtion);

  @override
  _ResultSeeMoreState createState() => _ResultSeeMoreState();
}

class _ResultSeeMoreState extends State<ResultSeeMore> {
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
          title: Center(child: Text(widget.selecetedDisease.disease.name
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                SizedBox(height: 30.0,),
                Text(
                  "${getLang(context, "Disease Name:")}",style: TextStyle(
                  color: ColorsConsts.blueText,
                  fontWeight: FontWeight.w500,
                  fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDisease.disease.name,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: ColorsConsts.primaryColor,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Text(
                  "${getLang(context, "Infection Possibility:")}",style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: LinearPercentIndicator(
                          animation: true,

                          lineHeight: 10.0,
                          animationDuration: 2000,
                          percent: widget.selecetedDisease.disease.accuracy/100.round(),
                          barRadius: Radius.circular(20.0),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: widget.selecetedDisease.disease.accuracy.round() < 25 ? ColorsConsts.under_25_Color :
                          widget.selecetedDisease.disease.accuracy.round() < 50 ? ColorsConsts.greater_25_Color :
                          widget.selecetedDisease.disease.accuracy.round() < 75 ? ColorsConsts.greater_50_Color :
                          widget.selecetedDisease.disease.accuracy.round() < 90 ? ColorsConsts.greater_75_Color :
                          widget.selecetedDisease.disease.accuracy.round() < 100 ? ColorsConsts.under_100_Color : Colors.white,
                          backgroundColor: Color(0xFFDADADA),
                        ),
                      ),
                      Text(
                        widget.selecetedDisease.disease.accuracy.round().toString()+"%",
                        style: TextStyle(
                          color: ColorsConsts.primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.0,),
                Text("ICD Code:",style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDisease.disease.icd,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                Text("ICD Name:",style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDisease.disease.icdName,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Text( "${getLang(context, "Profession Name:")}", style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDisease.disease.profName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Text(
                  "${getLang(context, "Medical Speciality:")}", style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    buildSpecNames(widget.selecetedDisease.specialisations).toString(),
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Text("${getLang(context, "Disease Description:")}",style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDiseaseDescribtion.describtion,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Text("Medial Conditions:",style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDiseaseDescribtion.medicalCondition,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Text(
                  "${getLang(context, "Synonyms:")}",style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDiseaseDescribtion.synonyms != null ? widget.selecetedDiseaseDescribtion.synonyms : "None",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                Text("${getLang(context, "Recommended Treatment:")}",style: TextStyle(
                    color: ColorsConsts.blueText,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),),
                SizedBox(height: 15.0,),
                Center(
                  child: Text(
                    widget.selecetedDiseaseDescribtion.recommendedTreatments,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        color: ColorsConsts.primaryColor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),


              ],
            ),
          ),
        ),
      ),
    );
  }
  String buildSpecNames(List<Specialisation> specializations)
  {
    String specializationString = "";
    for(Specialisation specialization in specializations)
    {
      if(!(specialization == specializations[specializations.length-1]))
        specializationString+=specialization.name+"-";
      else
        specializationString+=specialization.name;
    }
    return specializationString;
  }
}
