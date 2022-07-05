import 'dart:convert';

class DiagnosisChars
{
  String medicalCondition;
  String synonyms;
  String recommendedTreatments;
  String describtion;
  DiagnosisChars({
    this.describtion,
   this.medicalCondition,
   this.synonyms,
   this.recommendedTreatments
});
  DiagnosisChars.fromJson(Map<String,dynamic> json)
  {
    describtion = json['Description'];
    medicalCondition = json['MedicalCondition'];
    synonyms = json['Synonyms'];
    recommendedTreatments = json['TreatmentDescription'];
  }
}