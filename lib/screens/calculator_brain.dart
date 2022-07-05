class CalculatorBrain {
  CalculatorBrain({this.ageInMonth, this.weight, this.age});

  final int ageInMonth;
  final int weight;
  final int age;

  dynamic _bmi;

  String calculateBMI() {
    _bmi = ((weight * 15.0) * 5.0) / 125.0;
    return _bmi.toStringAsFixed(2);
  }

  String getResult() {
    if (age > 18) {
      return 'notice:Life expectancy for this medicine is between(1month-18year)';
    } else {
      return 'The minimum Dose in ml is:\n(TID) ';
    }
  }

  String calculateBMI2() {
    _bmi = ((weight * 30.0) * 5.0) / 125.0;
    return _bmi.toStringAsFixed(2);
  }

  String getResult2() {
    if (age > 18) {
      return 'notice:Life expectancy for this medicine is between(1month-18year)';
    } else {
      return 'The maximum Dose in ml is:\n(TID) ';
    }
  }

  String augmentionMin() {
    _bmi = ((weight * 0.25) / 1);
    return _bmi.toStringAsFixed(2);
  }

  String augmentionMinResult() {
    if (age > 11) {
      return 'notice:Life expectancy for this medicine is between(1month-11year)';
    } else {
      return 'The minimum Dose in ml is:\n(TID) ';
    }
  }

  String augmentionMax() {
    _bmi = ((weight * 0.5) / 1);
    return _bmi.toStringAsFixed(2);
  }

  String augmentionMaxResult() {
    if (age > 11) {
      return 'notice:Life expectancy for this medicine is between(1month-11year)';
    } else {
      return 'The maximum Dose in ml is:\n(TID) ';
    }
  }

  String azithromycinMin() {
    _bmi = ((weight * 10) / 40);
    return _bmi.toStringAsFixed(2);
  }

  String azithromycinMinResult() {
    if (ageInMonth < 6 && ageInMonth != 0) {
      return 'notice:Life expectancy for this medicine is over 6 month';
    } else if (age > 0 && ageInMonth == 0) {
      return 'The  Dose in ml is:\n(OD) ';
    } else {
      return 'The  Dose in ml is:\n(OD) ';
    }
  }

  String azithromycinMax() {
    return '';
  }

  String azithromycinMaxResult() {
    return '';
  }

  String cefuroximeMin() {
    if ((ageInMonth >= 3 && ageInMonth <= 12) ||
        (ageInMonth == 0 && age == 1)) {
      _bmi = ((weight * 10.0) * 5.0) / 125.0;
      return _bmi.toStringAsFixed(2);
    } else if (age >= 2 && age < 12) {
      _bmi = ((weight * 15.0) * 5.0) / 125.0;
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = ((weight * 15.0) * 5.0) / 125.0;
      return _bmi.toStringAsFixed(2);
    }
  }

  String cefuroximeMinResult() {
    if (ageInMonth < 3 || ageInMonth > 12) {
      return 'The  Dose in ml is:\n(BD)';
    } else if (age > 11) {
      return 'The  Dose in ml is:\n(BD)';
    } else {
      return 'The  Dose in ml is:\n(BD)';
    }
  }

  String cefuroximeMax() {
    return '';
  }

  String cefuroximeMaxResult() {
    if (ageInMonth < 3 && ageInMonth != 0 ||
        ageInMonth > 12 && ageInMonth != 0) {
      return 'notice:Life expectancy for this medicine is between(3month-1year)';
    } else if (ageInMonth > 3 && ageInMonth != 0 ||
        ageInMonth < 12 && ageInMonth != 0) {
      return 'notice:Life expectancy for this medicine is between(3month-1year)';
    } else if (0 < age && age <= 11) {
      return 'notice:Life expectancy for this medicine is between(2years-11year)';
    } else {
      return 'notice:Life expectancy for this medicine is between (3month-1year) or(2years-11year)';
    }
  }

  String cloxacillinMin() {
    if ((ageInMonth >= 1 && ageInMonth <= 12) ||
        (ageInMonth == 0 && age == 1)) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age >= 2 && age <= 9) {
      _bmi = 5.0;
      return _bmi.toString();
    } else if (age >= 10 && age <= 17) {
      _bmi = 10.0;
      return _bmi.toString();
    } else if (ageInMonth > 12) {
      _bmi = 5.0;
      return _bmi.toString();
    } else {
      _bmi = 10.0;
      return _bmi.toString();
    }
  }

  String cloxacillinMinResult() {
    if (age > 17) {
      return "notice:Life expectancy for this medicine is between(1month-17years)";
    } else {
      return 'The minimum Dose in ml is:\n(QID) ';
    }
  }

  String cloxacillinMax() {
    if ((ageInMonth >= 1 && ageInMonth <= 12) ||
        (ageInMonth == 0 && age == 1)) {
      _bmi = 5.0;
      return _bmi.toString();
    } else if (age >= 2 && age <= 9) {
      _bmi = 10.0;
      return _bmi.toString();
    } else if (age >= 10 && age <= 17) {
      _bmi = 20.0;
      return _bmi.toString();
    } else if (ageInMonth > 12) {
      _bmi = 10.0;
      return _bmi.toString();
    } else {
      _bmi = 20.0;
      return _bmi.toString();
    }
  }

  String cloxacillinMaxResult() {
    if (age > 17) {
      return "notice:Life expectancy for this medicine is between(1month-17years)";
    } else {
      return 'The maximum Dose in ml is:\n(QID) ';
    }
  }

  String cephalexinMin() {
    if (ageInMonth >= 1 && ageInMonth <= 11) {
      _bmi = ((weight * 12.5) * 5.0) / 125.0;
      return _bmi.toStringAsFixed(2);
    } else if (ageInMonth > 11) {
      _bmi = 5.0;
      return _bmi.toString();
    } else if (age >= 1 && age <= 4) {
      _bmi = 5.0;
      return _bmi.toString();
    } else if (age >= 5 && age <= 11) {
      _bmi = 10.0;
      return _bmi.toString();
    } else {
      _bmi = 10.0;
      return _bmi.toString();
    }
  }

  String cephalexinMinResult() {
    if (age > 11) {
      return 'notice:Life expectancy for this medicine is between(1month-11year)';
    } else if (ageInMonth >= 1 && ageInMonth <= 12) {
      return 'The Dose in ml is:\n(BD) ';
    } else {
      return 'The Dose in ml is:\n(TID) ';
    }
  }

  String cephalexinMax() {
    return '';
  }

  String cephalexinMaxResult() {
    return '';
  }

  String melronidazoleMin() {
    _bmi = ((weight * 7.5) * 5.0) / 200.0;
    return _bmi.toStringAsFixed(2);
  }

  String melronidazoleMinResult() {
    if (ageInMonth == 1) {
      return 'The Dose in ml is:\n(BD) ';
    } else if (age > 12) {
      return 'notice:Life expectancy for this medicine is between(1month-11year)';
    } else {
      return 'The Dose in ml is:\n(TID) ';
    }
  }

  String melronidazoleMax() {
    return '';
  }

  String melronidazoleMaxResult() {
    return '';
  }

  String erythromycinMin() {
    if (ageInMonth >= 1 && ageInMonth <= 12) {
      _bmi = 3.125;
      return _bmi.toString();
    } else if (age == 1) {
      _bmi = 3.125;
      return _bmi.toString();
    } else if (age >= 2 && age <= 7) {
      _bmi = 6.25;
      return _bmi.toString();
    } else {
      _bmi = 6.25;
      return _bmi.toString();
    }
  }

  String erythromycinMinResult() {
    if (age > 7) {
      return 'notice:Life expectancy for this medicine is between(1month-7year)';
    } else {
      return 'The Dose in ml is:\n(QID)';
    }
  }

  String erythromycinMax() {
    return '';
  }

  String erythromycinMaxResult() {
    return '';
  }

  String phenoxyMin() {
    if (ageInMonth >= 1 && ageInMonth <= 12) {
      _bmi = 1.25;
      return _bmi.toString();
    } else if (ageInMonth > 12) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age == 1) {
      _bmi = 1.25;
      return _bmi.toString();
    } else if (age >= 2 && age <= 6) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age >= 7 && age <= 12) {
      _bmi = 5.0;
      return _bmi.toString();
    } else {
      _bmi = 5.0;
      return _bmi.toString();
    }
  }

  String phenoxyMinResult() {
    if (age > 12) {
      return 'notice:Life expectancy for this medicine is between(1month-12year)';
    } else {
      return 'The Dose in ml is:\n(QID)';
    }
  }

  String phenoxyMax() {
    return '';
  }

  String phenoxyMaxResult() {
    return '';
  }

  String paracetamolSyrupMin() {
    _bmi = ((weight * 10.0) * 5.0) / 120.0;
    return _bmi.toStringAsFixed(2);
  }

  String paracetamolSyrupMinResult() {
    if (age > 12) {
      return 'notice:Life expectancy for this medicine is between(2year-12year)';
    } else {
      return 'The minimum Dose in ml is: ';
    }
  }

  String paracetamolSyrupMax() {
    _bmi = ((weight * 15.0) * 5.0) / 120.0;
    return _bmi.toStringAsFixed(2);
  }

  String paracetamolSyrupMaxResult() {
    if (age > 12) {
      return 'notice:Life expectancy for this medicine is between(2year-12year)';
    } else {
      return 'The Maximum Dose in ml is: ';
    }
  }

  String paracetamolDropsMin() {
    _bmi = ((weight * 10.0) * 1) / 100.0;
    return _bmi.toStringAsFixed(2);
  }

  String paracetamolDropsMinResult() {
    if (ageInMonth > 12) {
      return 'notice:Life expectancy for this medicine is between(1Day-1year)';
    } else if (age > 1) {
      return 'notice:Life expectancy for this medicine is between(1Day-1year)';
    } else {
      return 'The minimum Dose in ml is: ';
    }
  }

  String paracetamolDropsMax() {
    _bmi = ((weight * 15.0) * 1) / 100.0;
    return _bmi.toStringAsFixed(2);
  }

  String paracetamolDropsMaxResult() {
    if (ageInMonth > 12) {
      return 'notice:Life expectancy for this medicine is between(1Day-1year)';
    } else if (age > 1) {
      return 'notice:Life expectancy for this medicine is between(1Day-1year)';
    } else {
      return 'The Maximum Dose in ml is: ';
    }
  }

  String ibuprofinMin() {
    if (ageInMonth > 0) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age >= 1 && age <= 2) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age >= 3 && age <= 7) {
      _bmi = 5.0;
      return _bmi.toString();
    } else if (age >= 8 && age <= 12) {
      _bmi = 10.0;
      return _bmi.toString();
    } else {
      _bmi = 10.0;
      return _bmi.toString();
    }
  }

  String ibuprofinMinResult() {
    if (ageInMonth > 12) {
      return 'notice:Life expectancy for this medicine is between(1year-12year)';
    } else {
      return 'The  Dose in ml is:\n(TID) ';
    }
  }

  String ibuprofinMax() {
    return '';
  }

  String ibuprofinMaxResult() {
    return 'notice:Not Recommended for children less than 7 KG';
  }

  String chlorpheniramineMin() {
    if (ageInMonth > 0) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age >= 1 && age <= 2) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age > 2 && age <= 5) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age >= 6 && age <= 12) {
      _bmi = 5.0;
      return _bmi.toString();
    } else {
      _bmi = 5.0;
      return _bmi.toString();
    }
  }

  String chlorpheniramineMinResult() {
    if (age > 12) {
      return 'notice:Life expectancy for this medicine is between(1month-12year)';
    } else if (ageInMonth > 0) {
      return 'the Dose in ml is:\n(BD)';
    } else if (age >= 1 && age <= 2) {
      return 'the Dose in ml is:\n(BD)';
    } else {
      return 'the Dose in ml is:\n(TID)';
    }
  }

  String chlorpheniramineMax() {
    return '';
  }

  String chlorpheniramineMaxResult() {
    return '';
  }

  String actifedSyrupMin() {
    if (age >= 2 && age <= 5) {
      _bmi = 2.5;
      return _bmi.toString();
    } else if (age > 5 && age <= 12) {
      _bmi = 5.0;
      return _bmi.toString();
    } else if (ageInMonth > 0) {
      _bmi = 2.5;
      return _bmi.toString();
    } else {
      _bmi = 5.0;
      return _bmi.toString();
    }
  }

  String actifedSyrupMinResult() {
    if (age > 12) {
      return 'notice:Life expectancy for this medicine is between(2year-12year)';
    } else if (ageInMonth > 0) {
      return 'notice:Life expectancy for this medicine is between(2year-12year)';
    } else {
      return 'the Dose in ml is:\n(TID)';
    }
  }

  String actifedSyrupMax() {
    return '';
  }

  String actifedSyrupMaxResult() {
    return '';
  }

  String domporidoneSuspensionMin() {
    if (weight < 35) {
      _bmi = (weight * 0.25) / 5;
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = ((weight * 10.0) / 5);
      return _bmi.toStringAsFixed(2);
    }
  }

  String domporidoneSuspensionMinResult() {
    return 'the minimum Dose in ml is:\n(TID)';
  }

  String domporidoneSuspensionMax() {
    if (weight < 35) {
      _bmi = ((weight * 0.5) / 5);
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = ((weight * 20.0) / 5);
      return _bmi.toStringAsFixed(2);
    }
  }

  String domporidoneSuspensionMaxResult() {
    return 'the max Dose in ml is:\n(TID)';
  }

  String promethazineMin() {
    if (age >= 2 && age <= 10) {
      _bmi = 5;
      return _bmi.toStringAsFixed(2);
    } else if (age > 10 && age <= 18) {
      _bmi = 10;
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = 20;
      return _bmi.toStringAsFixed(2);
    }
  }

  String promethazineMinResult() {
    if (age > 18) {
      return 'notice:Life expectancy for this medicine is between(2years-18years)';
    } else if (ageInMonth != 0) {
      return 'notice:Life expectancy for this medicine is between(2years-18years)';
    } else {
      return 'the minimum Dose in ml is:\n(BD)';
    }
  }

  String promethazineMax() {
    if (age >= 2 && age <= 5) {
      _bmi = 5;
      return _bmi.toStringAsFixed(2);
    } else if (age > 5 && age <= 10) {
      _bmi = 10;
      return _bmi.toStringAsFixed(2);
    } else if (age > 10 && age <= 18) {
      _bmi = 20;
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = 20;
      return _bmi.toStringAsFixed(2);
    }
  }

  String promethazineMaxResult() {
    if (age > 18) {
      return 'notice:Life expectancy for this medicine is between(2years-18year)';
    } else if (ageInMonth != 0) {
      return 'notice:Life expectancy for this medicine is between(2years-18years)';
    } else {
      return 'the max Dose in ml is:\n(BD)';
    }
  }

  String lactuloseMin() {
    if ((ageInMonth > 0 && ageInMonth <= 12) || (age > 0 && age <= 5)) {
      _bmi = 2.5;
      return _bmi.toStringAsFixed(2);
    } else if (age > 5 && age <= 18) {
      _bmi = 5;
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = 5;
      return _bmi.toStringAsFixed(2);
    }
  }

  String lactuloseMinResult() {
    if (age > 18) {
      return 'notice:Life expectancy for this medicine is between(1month-18years)';
    } else {
      return 'the minimum Dose in ml is:\n(BD)';
    }
  }

  String lactuloseMax() {
    if ((age > 0 && age <= 5)) {
      _bmi = 10;
      return _bmi.toStringAsFixed(2);
    } else if (age > 5 && age <= 18) {
      _bmi = 20;
      return _bmi.toStringAsFixed(2);
    } else if (ageInMonth > 0) {
      _bmi = 2.5;
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = 20;
      return _bmi.toStringAsFixed(2);
    }
  }

  String lactuloseMaxResult() {
    if (age > 18) {
      return 'notice:Life expectancy for this medicine is between(1month-18years)';
    } else {
      return 'the max Dose in ml is:\n(BD)';
    }
  }

  String nystatinMin() {
    if (ageInMonth > 0) {
      _bmi = 1;
      return _bmi.toStringAsFixed(2);
    } else if (age > 0 && age <= 18) {
      _bmi = 1;
      return _bmi.toStringAsFixed(2);
    } else {
      _bmi = 5;
      return _bmi.toStringAsFixed(2);
    }
  }

  String nystatinMinResult() {
    return 'the dose in ml is:\n(OD)';
  }

  String nystatinMax() {
    return '';
  }

  String nystatinMaxResult() {
    return '';
  }

  String ferrousMin() {
   if(ageInMonth<=12){
     _bmi = 0.5;
     return _bmi.toStringAsFixed(2);
   }else{
     return'wrong';
   }
  }

  String ferrousMinResult() {
    if(ageInMonth>12||age>1){
      return'notice:Life expectancy for this medicine is between(1month-12month)';
    }else{
      return 'the minimum dose in ml is:\n(OD)';
    }
  }

  String ferrousMax() {
    if(ageInMonth<=12){
      _bmi = 1.2;
      return _bmi.toStringAsFixed(2);
    }else{
      return'wrong';
    }
  }

  String ferrousMaxResult() {
    if(ageInMonth>12||age>1){
      return'notice:Life expectancy for this medicine is between(1month-12month)';
    }else{
      return 'the max dose in ml is:\n(OD)';
    }
  }

  String multivitaminMin() {
    if(age>=4){
      _bmi = 5;
      return _bmi.toStringAsFixed(2);
    }else if(age<4 || ageInMonth>0){
      return'wrong';
    }else{
      return'wrong';
    }
  }

  String multivitaminMinResult() {
    if(age<4 || ageInMonth>0){
      return'notice:Life expectancy for this medicine is above 4 years';
    }else{
      return'the dose in ml is:\n(OD)';
    }
  }

  String multivitaminMax() {
    return '';
  }

  String multivitaminMaxResult() {
    return '';
  }

  String albendazoleMin() {
  if(age>0&&age<=2){
    _bmi = 10;
    return _bmi.toStringAsFixed(2);
  }else if(age>2){
    _bmi = 20;
    return _bmi.toStringAsFixed(2);
  }else if(ageInMonth<12){
    return'wrong';
  }else{
    _bmi = 10;
    return _bmi.toStringAsFixed(2);
  }
  }

  String albendazoleMinResult() {
if(ageInMonth<12){
  return'notice:Life expectancy for this medicine is above 1 year';
}else{
  return'the dose in ml is:\n(OD)';
}
  }

  String albendazoleMax() {
    return '';
  }

  String albendazoleMaxResult() {
    return '';
  }
}
