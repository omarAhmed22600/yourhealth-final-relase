import 'package:flutter/material.dart';
import 'package:sehetak2/components/bottom_button.dart';
import 'package:sehetak2/components/reusable_card.dart';

import 'package:sehetak2/screens/constants.dart';

class ResultsPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ResultsPage(
      {@required this.bmiResult2,
      @required this.bmiResult,
      @required this.resultText,
      @required this.resultText2
      });

  final String bmiResult;
  final String resultText;
  final String bmiResult2;
  final String resultText2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pediatric Dose'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Your Result',
                style: kTitleTextStyle,
                
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 70.0,),
                  Text(
                    resultText,
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style: kBMITextStyle,
                  ),
                    Text(
                    resultText2,
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult2,
                    style: kBMITextStyle,
                  ),
                  // Text(
                  //   interpretation,
                  //   textAlign: TextAlign.center,
                  //   style: kBodyTextStyle,
                  // ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
