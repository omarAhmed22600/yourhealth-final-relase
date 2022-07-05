class DiagnosisResult
{
  Disease disease;
  List<Specialisation> specialisations;
  DiagnosisResult({
    this.disease,
    this.specialisations
});
  DiagnosisResult.fromJson(Map<String,dynamic> json)
  {
    disease = Disease.fromJson(json['Issue']);
    specialisations = Specialisation.fromListMap(json['Specialisation']);
  }
  static List<DiagnosisResult> fromListMap(List<dynamic> json)
  {
    DiagnosisResult diagnosisResult;
    List<DiagnosisResult> diagnosisResults = [];
    for(Map element in json)
    {
      diagnosisResult = DiagnosisResult.fromJson(element);
      diagnosisResults.add(diagnosisResult);
    }
    return diagnosisResults;
  }
}
class Specialisation {
  int id;
  String name;
  int specialistId;
  Specialisation({
    this.id,
    this.name,
    this.specialistId
});
  Specialisation.fromJson(Map<String,dynamic> json)
  {
    id = json['ID'] ;
    name = json['Name'];
    specialistId = json['SpecialistID'];
  }
  static List<Specialisation> fromListMap(List<dynamic> json)
  {
    Specialisation specialisation;
    List<Specialisation> specialisations = [];
    for(Map element in json)
    {
      specialisation = Specialisation.fromJson(element);
      specialisations.add(specialisation);
    }
    return specialisations;
  }
}

class Disease {
  int id;
  String name;
  dynamic accuracy;
  String icd;
  String icdName;
  String profName;
  int ranking;
  Disease({
    this.id,
    this.name,
    this.accuracy,
    this.icd,
    this.icdName,
    this.profName,
    this.ranking,
});
  Disease.fromJson(Map<String,dynamic> json)
  {
    id = json['ID'] ;
    name = json['Name'];
    accuracy = json['Accuracy'];
    icd = json['Icd'];
    icdName = json['IcdName'];
    profName = json['ProfName'];
    ranking = json['Ranking'];
  }
}