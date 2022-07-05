import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sehetak2/consts/colors.dart';

import 'package:sehetak2/models/diagnosis_results_model.dart';
import 'package:sehetak2/screens/initial_diagnosis/intial_diagnosis_results.dart';
import 'package:sehetak2/screens/user_state.dart';

import '../../components/applocal.dart';

class DiagnosisHistory extends StatefulWidget {

  @override
  _DiagnosisHistoryState createState() => _DiagnosisHistoryState();
}

class _DiagnosisHistoryState extends State<DiagnosisHistory> {
  List<List<DiagnosisResult>> diagnosis = [];
  List<DateTime> dates = [];
  List<String> genders = [];
  List<int> ages = [];
  List<List<dynamic>> diagnosisSymptoms = [];
  bool isDataLoaded = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initHistory();
      setState(() { });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [const Color(0xffe4f2f7), Colors.white]),

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search,
              ),
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(diagnosisSymptoms,diagnosis,dates,genders,ages)
                );
              },
            ),
          ],
          elevation: 5.0,
          backgroundColor: ColorsConsts.primaryColor,
          toolbarHeight: 65.0,
          title:  Center(child:  Text(
              "${getLang(context,  "Diagnosis History")}",
          )),
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: ConditionalBuilder(condition: isDataLoaded,
            builder: (build) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.separated(
                      itemBuilder: (context,index) => buildDiagnosisItem(index),
                      separatorBuilder: (context,index) => const SizedBox(height: 20.0,),
                      itemCount: diagnosis.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          fallback: (build) => const Center(child: const CircularProgressIndicator(color: Colors.blue,)),
        ),
      ),
    );
  }

    initHistory() async{
    FirebaseFirestore.instance.collection("diagnosis").where("userID",isEqualTo: UserState.userID).orderBy("date",descending: true).orderBy("time", descending: true).snapshots().listen((event) {
      event.docs.forEach((element) {
        if(element.data()['diagnosisInfo'].isNotEmpty) {
          diagnosis.add(DiagnosisResult.fromListMap(element.data()['diagnosisInfo']));
          ages.add(DateTime.now().year - element.data()['birthYear']);
          genders.add(element.data()['gender']);
          dates.add(new DateFormat("yyyy-MM-dd").parse(element.data()['date']));
          diagnosisSymptoms.add(element.data()['symptoms']);
      }
        isDataLoaded = true;
        setState(() { });
        diagnosis.forEach((element) {
          element.forEach((element) {
            print(element.disease.name);
          });
          print("-------------------------");
        });
      });
    });
  }
  Widget buildDiagnosisItem(index)
  {
    return InkWell(
      onTap: ()
      {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DiagnosisResults(DateTime.now().year - ages[index],genders[index],[],diagnosisSymptoms[index],true,diagnosis[index])));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400]
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: genders[index] != "Male" ?
                const AssetImage("assets/images/female_user.png")  : const AssetImage("assets/images/male_user.png") ,
              ),
              const SizedBox(width: 10.0,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(diagnosisSymptoms[index].length-1 >= 1 ? diagnosisSymptoms[index][0] +", "+ diagnosisSymptoms[index][1]:
                    diagnosisSymptoms[index][0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Gender: ${genders[index]}"),
                        const Spacer(),
                        Text("Age: ${ages[index].toString()}"),
                        const Spacer(),
                        Text(dates[index].day.toString()+"-"+dates[index].month.toString()+"-"+dates[index].year.toString()),

                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MySearchDelegate extends SearchDelegate
{
  List<List<DiagnosisResult>> diagnosis = [];
  List<DateTime> dates = [];
  List<String> genders = [];
  List<int> ages = [];
  List<List<dynamic>> diagnosisSymptoms = [];
  List<String> searchSymptoms = [];
  MySearchDelegate(this.diagnosisSymptoms,this.diagnosis,this.dates,this.genders,this.ages)
  {
    searchSymptoms = adjustList();

  }

  @override
  List<Widget> buildActions(BuildContext context) => [IconButton(
    icon: const Icon(Icons.clear),
    onPressed: (){
      query = '';
    },
  )];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back)
  );

  @override
  Widget buildResults(BuildContext context) => const SizedBox();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<int> suggestions = [];
    searchSymptoms.forEachIndexed((index, element){
      final String result = element.toLowerCase();
      final String input  = query.toLowerCase();
      result.contains(input) ? suggestions.add(index) : null;
    });
    print(genders.length.toString());
    print(suggestions.length.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 20.0,),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index)
              {
                final int suggestionIndex = suggestions[index];

                if(suggestionIndex != null) {
                  return buildDiagnosisItem(suggestionIndex, context);
                }
              },
              separatorBuilder: (context,index) => const SizedBox(height: 20.0,),
              itemCount: suggestions.length,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildDiagnosisItem(index,context,)
  {
    return InkWell(
      onTap: ()
      {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DiagnosisResults(DateTime.now().year - ages[index],genders[index],[],diagnosisSymptoms[index],true,diagnosis[index])));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[400]
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: genders[index] != "Male" ?
                const AssetImage("assets/images/female_user.png")  : const AssetImage("assets/images/male_user.png") ,
              ),
              const SizedBox(width: 10.0,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(diagnosisSymptoms[index].length-1 >= 1 ? diagnosisSymptoms[index][0] +", "+ diagnosisSymptoms[index][1]:
                    diagnosisSymptoms[index][0],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Gender: ${genders[index]}"),
                        const Spacer(),
                        Text("Age: ${ages[index].toString()}"),
                        const Spacer(),
                        Text(dates[index].day.toString()+"-"+dates[index].month.toString()+"-"+dates[index].year.toString()),

                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<String> adjustList()
  {
    if(searchSymptoms.isEmpty) {
      List<String> adjustedSymptoms = [];
      for (List<dynamic> element in diagnosisSymptoms) {
        adjustedSymptoms.add(element[0]);
        print(element[0]);
      }
      print("adjusted"+adjustedSymptoms.length.toString()+"--before ${diagnosisSymptoms.length}");
      return adjustedSymptoms;
    }
  }

}
