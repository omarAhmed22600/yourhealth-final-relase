import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehetak2/components/bottom_button.dart';
import 'package:sehetak2/components/icon_content.dart';
import 'package:sehetak2/components/reusable_card.dart';
import 'package:sehetak2/components/round_icon_button.dart';
import 'package:sehetak2/screens/calculator_brain.dart';
import 'package:sehetak2/screens/constants.dart';
import 'package:sehetak2/screens/pediatric/results_page.dart';


enum Gender {
  male,
  female,
}

// ignore: must_be_immutable
class InputPage extends StatefulWidget {
  InputPage({
    Key key,
    @required this.selected,
  }) : super(key: key);

  // ignore: prefer_const_constructors_in_immutables
  String selected;

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  Gender selectedGender;
  int ageInMonths = 0;
  int weight = 20;
  int age = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selected),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Scroll for more....',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 70.0,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Text(
                          widget.selected,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 11, 80, 158),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  colour: selectedGender == Gender.male
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: const IconContent(
                    icon: FontAwesomeIcons.male,
                    
                    label: 'MALE',
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  colour: selectedGender == Gender.female
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: const IconContent(
                    icon: FontAwesomeIcons.female,
                    label: 'FEMALE',
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'AGE IN MONTH',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          ageInMonths.toString(),
                          style: kNumberTextStyle,
                        ),
                        const Text(
                          'mon',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: const Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: const Color(0xFFEB1555),
                        overlayColor: const Color(0x29EB1555),
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: ageInMonths.toDouble(),
                        min: 0.0,
                        max: 20.0,
                        onChanged: (double newValue) {
                          setState(() {
                            ageInMonths = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                }),
                            const SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              age.toString(),
                              style: kNumberTextStyle,
                            ),
                            const Text(
                              'year',
                              style: kLabelTextStyle,
                            )
                          ],
                        ),
                        // Text(
                        //   age.toString(),
                        //   style: kNumberTextStyle,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(
                                  () {
                                    age--;
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(
                  ageInMonth: ageInMonths, weight: weight, age: age);

              Navigator.push(
                context,
                // ignore: missing_return
                MaterialPageRoute(builder: (context) {
                  if (widget.selected ==
                      'Amoxicillin consentration(125mg/5ml)\n\nTarget Dose:15-30mg/kg/TID\n\nMax Dose:4g/daily') {
                    return ResultsPage(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.getResult(),
                      bmiResult2: calc.calculateBMI2(),
                      resultText2: calc.getResult2(),
                    );
                  } else if (widget.selected ==
                      'Augmentin consentration(156mg/5ml)\n\nTarget Dose:0.25ml-0.5ml/kg/TID\n\nMax Dose:4g/day') {
                    return ResultsPage(
                      bmiResult: calc.augmentionMin(),
                      resultText: calc.augmentionMinResult(),
                      bmiResult2: calc.augmentionMax(),
                      resultText2: calc.augmentionMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Azithromycin consentration(40mg/1ml)\n\nTarget Dose:10mg/kg/OD for 3days\n\nMax Dose:500mg/day') {
                    return ResultsPage(
                      bmiResult: calc.azithromycinMin(),
                      resultText: calc.azithromycinMinResult(),
                      bmiResult2: calc.azithromycinMax(),
                      resultText2: calc.azithromycinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Cefuroxime consentration(125mg/5ml)\nTarget Dose(3month-1year):10mg/kg/BD\nTarget Dose(2years-11years):15mg/kg/BD\nMax Dose:(3month-2years):125mg/kg\nMax Dose:(2years-12years):250mg/kg') {
                    return ResultsPage(
                      bmiResult: calc.cefuroximeMin(),
                      resultText: calc.cefuroximeMinResult(),
                      bmiResult2: calc.cefuroximeMax(),
                      resultText2: calc.cefuroximeMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Cloxacillin consentration(125mg/5ml)\nTarget Dose(1month-1year):62.5mg-125mg/QID\nTarget Dose(2years-9years):125mg-250mg/QID\nTarget Dose(10years-17years):250mg-500mg/QID\nMax Dose:4g/day') {
                    return ResultsPage(
                      bmiResult: calc.cloxacillinMin(),
                      resultText: calc.cloxacillinMinResult(),
                      bmiResult2: calc.cloxacillinMax(),
                      resultText2: calc.cloxacillinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Cephalexin consentration(125mg/5ml)\nTarget Dose(1month-11month):12.5mg/kg/BD\nTarget Dose(1year-4years):125mg/kg/TID\nTarget Dose(5years-11years):250mg/kg/TID\nMax Dose:4g/day') {
                    return ResultsPage(
                      bmiResult: calc.cephalexinMin(),
                      resultText: calc.cephalexinMinResult(),
                      bmiResult2: calc.cephalexinMax(),
                      resultText2: calc.cephalexinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Metronidazole consentration(200mg/5ml)\nTarget Dose(1month):7.5mg/kg/BD\nTarget Dose(2month-11years):7.5mg/kg/TID\nMax Dose:4g/day') {
                    return ResultsPage(
                      bmiResult: calc.melronidazoleMin(),
                      resultText: calc.melronidazoleMinResult(),
                      bmiResult2: calc.melronidazoleMax(),
                      resultText2: calc.melronidazoleMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Erythromycin consentration(200mg/5ml)\nTarget Dose(1month-1year):125mg/QID\nTarget Dose(2year-7years):250mg/QID\nMax Dose:1g/day') {
                    return ResultsPage(
                      bmiResult: calc.erythromycinMin(),
                      resultText: calc.erythromycinMinResult(),
                      bmiResult2: calc.erythromycinMax(),
                      resultText2: calc.erythromycinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Phenoxy methyl penicillin consentration(250mg/5ml)\nTarget Dose(1month-1year):62.5mg/QID\nTarget Dose(1year-6years):125mg/QID\nTarget Dose(6year-12years):250mg/QID\nMax Dose: 4doses in 24hours') {
                    return ResultsPage(
                      bmiResult: calc.phenoxyMin(),
                      resultText: calc.phenoxyMinResult(),
                      bmiResult2: calc.phenoxyMax(),
                      resultText2: calc.phenoxyMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Paracetamol syrup consentration(120mg/5ml)\nTarget Dose(2years-12years):10-15mg/kg\nMax Dose: 4doses in 24hours') {
                    return ResultsPage(
                      bmiResult: calc.paracetamolSyrupMin(),
                      resultText: calc.paracetamolSyrupMinResult(),
                      bmiResult2: calc.paracetamolSyrupMax(),
                      resultText2: calc.paracetamolSyrupMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Paracetamol Drops consentration(100mg/1ml)\nTarget Dose(1day-1year):10-15mg/kg\nMax Dose: 4doses in 24hours') {
                    return ResultsPage(
                      bmiResult: calc.paracetamolDropsMin(),
                      resultText: calc.paracetamolDropsMinResult(),
                      bmiResult2: calc.paracetamolDropsMax(),
                      resultText2: calc.paracetamolDropsMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Ibuprofen consentration(100mg/5ml)\nTarget Dose(1year-2years):50mg/TID\nTarget Dose(3year-7years):100mg/TID\nTarget Dose(8year-12years):200mg/TID\nMax Dose:2400mg/Day') {
                    return ResultsPage(
                      bmiResult: calc.ibuprofinMin(),
                      resultText: calc.ibuprofinMinResult(),
                      bmiResult2: calc.ibuprofinMax(),
                      resultText2: calc.ibuprofinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Chlorpheniramine Maleate consentration(2mg/5ml)\nTarget Dose(1month-2years):1mg/BD\nTarget Dose(2years-5years):1mg/TID\nTarget Dose(6years-12years):2mg/TID\nMax Dose(2Y-6Y):12mg/day Max Dose(12Y-18Y):24mg/day') {
                    return ResultsPage(
                      bmiResult: calc.chlorpheniramineMin(),
                      resultText: calc.chlorpheniramineMinResult(),
                      bmiResult2: calc.chlorpheniramineMax(),
                      resultText2: calc.chlorpheniramineMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Actifed Syrup consentration(30mg/5ml)\nTarget Dose(2years-5years):2.5ml/TID\nTarget Dose(5years-12years):5ml/TID\nMax Dose:10ml 4times/day') {
                    return ResultsPage(
                      bmiResult: calc.actifedSyrupMin(),
                      resultText: calc.actifedSyrupMinResult(),
                      bmiResult2: calc.actifedSyrupMax(),
                      resultText2: calc.actifedSyrupMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Promethazine HCI consentration(5mg/5ml)\nTarget Dose(2years-5years):5ml/BD\nTarget Dose(5years-10years):5-10ml/BD\nTarget Dose(10years-18years):10-20ml/BD') {
                    return ResultsPage(
                      bmiResult: calc.promethazineMin(),
                      resultText: calc.promethazineMinResult(),
                      bmiResult2: calc.promethazineMax(),
                      resultText2: calc.promethazineMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Lactulose\nTarget Dose(1month-1year):2.5ml/BD\nTarget Dose(1year-5years):2.5-10ml/BD\nTarget Dose(5years-18years):5-20ml/BD') {
                    return ResultsPage(
                      bmiResult: calc.lactuloseMin(),
                      resultText: calc.lactuloseMinResult(),
                      bmiResult2: calc.lactuloseMax(),
                      resultText2: calc.lactuloseMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Nystatin consentration(100K I.U/1ml)\nTarget Dose(1month baby):1ml/OD\nTarget Dose(older than 1month baby):1ml/OD\nTarget Dose(older than 18years):5ml/OD') {
                    return ResultsPage(
                      bmiResult: calc.nystatinMin(),
                      resultText: calc.nystatinMinResult(),
                      bmiResult2: calc.nystatinMax(),
                      resultText2: calc.nystatinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Nystatin consentration(100K I.U/1ml)\nTarget Dose(1month baby):1ml/OD\nTarget Dose(older than 1month baby):1ml/OD\nTarget Dose(older than 18years):5ml/OD') {
                    return ResultsPage(
                      bmiResult: calc.nystatinMin(),
                      resultText: calc.nystatinMinResult(),
                      bmiResult2: calc.nystatinMax(),
                      resultText2: calc.nystatinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Nystatin consentration(100K I.U/1ml)\nTarget Dose(1month baby):1ml/OD\nTarget Dose(older than 1month baby):1ml/OD\nTarget Dose(older than 18years):5ml/OD') {
                    return ResultsPage(
                      bmiResult: calc.nystatinMin(),
                      resultText: calc.nystatinMinResult(),
                      bmiResult2: calc.nystatinMax(),
                      resultText2: calc.nystatinMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Ferrous Sulphate Drops consentration(125mg/1ml)\nTarget Dose(1month-12month):0.5-1.2ml/OD') {
                    return ResultsPage(
                      bmiResult: calc.ferrousMin(),
                      resultText: calc.ferrousMinResult(),
                      bmiResult2: calc.ferrousMax(),
                      resultText2: calc.ferrousMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Multivitamin Syrup\nTarget Dose(above 4yeas):5ml/OD') {
                    return ResultsPage(
                      bmiResult: calc.multivitaminMin(),
                      resultText: calc.multivitaminMinResult(),
                      bmiResult2: calc.multivitaminMax(),
                      resultText2: calc.multivitaminMaxResult(),
                    );
                  } else if (widget.selected ==
                      'Albendazole Suspension consentration(100mg/5ml)\nTarget Dose(1-2years):10ml and repeat after 7days\nTarget Dose(over 2years):20ml and repeat after 7days') {
                    return ResultsPage(
                      bmiResult: calc.albendazoleMin(),
                      resultText: calc.albendazoleMinResult(),
                      bmiResult2: calc.albendazoleMax(),
                      resultText2: calc.albendazoleMaxResult(),
                    );
                  } else {
                    return null;
                  }
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
