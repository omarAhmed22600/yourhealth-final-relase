import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Symptom
{
  int id;
  String name;
  Symptom({
    this.name,
    this.id,
});
  Symptom.fromJson(Map<String,dynamic> json)
  {
    id = json['ID'] ;
    name = json['Name'];
  }
  static List<Symptom> fromListMap(List<Map<String,dynamic>> json)
  {
    Symptom symptom;
    List<Symptom> symptoms = [];
    for(Map element in json)
      {
        symptom = Symptom.fromJson(element);
        symptoms.add(symptom);
      }
    return symptoms;
  }
  static Map<String, dynamic> toMap(Symptom symptom) => {
    'ID': symptom.id,
    'Name': symptom.name,
  };

  static String encode(List<Symptom> symptoms) => json.encode(
    symptoms
        .map<Map<String, dynamic>>((music) => Symptom.toMap(music))
        .toList(),
  );

  static List<Symptom> decode(String symptoms) =>
      (json.decode(symptoms) as List<dynamic>)
          .map<Symptom>((item) => Symptom.fromJson(item))
          .toList();
}