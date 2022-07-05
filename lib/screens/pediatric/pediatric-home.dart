import 'package:flutter/material.dart';
import 'package:sehetak2/screens/webView.dart';

import 'input_page.dart';

class MakeDashboardItems extends StatefulWidget {
  const MakeDashboardItems({Key key}) : super(key: key);

  @override
  _MakeDashboardItemsState createState() => _MakeDashboardItemsState();
}

class _MakeDashboardItemsState extends State<MakeDashboardItems> {
  Card makeDashboardItem(String title, String img, int index) {
    return Card(
      
      elevation: 0,
      margin: const EdgeInsets.all(2),
      child: Container(
        
        decoration: index == 0 ||
                index == 3 ||
                index == 4 ||
                index == 7 ||
                index == 8 ||
                index == 11 ||
                index == 12 ||
                index == 15 ||
                index == 16 ||
                index == 19
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                 
                  Color(0xFF80B1FE).withOpacity(.1),
                   Color(0xFFFFFFFF).withOpacity(.8),
                ]))
            : BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                  0.1,
                  0.9
                ], colors: [
                   Color(0xFF80B1FE).withOpacity(.1),
                   Color(0xFFFFFFFF).withOpacity(.8),
                   
                
                ])),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //  InputPageState(selected:"Amoxicllin consentration(125mg/5ml)" );
              //1.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Amoxicillin consentration(125mg/5ml)\n\nTarget Dose:15-30mg/kg/TID\n\nMax Dose:4g/daily',
                  ),
                ),
              );
            }
            if (index == 1) {
              //2.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Augmentin consentration(156mg/5ml)\n\nTarget Dose:0.25ml-0.5ml/kg/TID\n\nMax Dose:4g/day',
                  ),
                ),
              );
            }
            if (index == 2) {
              //3.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Azithromycin consentration(40mg/1ml)\n\nTarget Dose:10mg/kg/OD for 3days\n\nMax Dose:500mg/day',
                  ),
                ),
              );
            }
            if (index == 3) {
              //4.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Cefuroxime consentration(125mg/5ml)\nTarget Dose(3month-1year):10mg/kg/BD\nTarget Dose(2years-11years):15mg/kg/BD\nMax Dose:(3month-2years):125mg/kg\nMax Dose:(2years-12years):250mg/kg',
                  ),
                ),
              );
            }
            if (index == 4) {
              //5.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Cloxacillin consentration(125mg/5ml)\nTarget Dose(1month-1year):62.5mg-125mg/QID\nTarget Dose(2years-9years):125mg-250mg/QID\nTarget Dose(10years-17years):250mg-500mg/QID\nMax Dose:4g/day',
                  ),
                ),
              );
            }
            if (index == 5) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Cephalexin consentration(125mg/5ml)\nTarget Dose(1month-11month):12.5mg/kg/BD\nTarget Dose(1year-4years):125mg/kg/TID\nTarget Dose(5years-11years):250mg/kg/TID\nMax Dose:4g/day',
                  ),
                ),
              );
            }
            if (index == 6) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Metronidazole consentration(200mg/5ml)\nTarget Dose(1month):7.5mg/kg/BD\nTarget Dose(2month-11years):7.5mg/kg/TID\nMax Dose:4g/day',
                  ),
                ),
              );
            }
            if (index == 7) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Erythromycin consentration(200mg/5ml)\nTarget Dose(1month-1year):125mg/QID\nTarget Dose(2year-7years):250mg/QID\nMax Dose:1g/day',
                  ),
                ),
              );
            }
            if (index == 8) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Phenoxy methyl penicillin consentration(250mg/5ml)\nTarget Dose(1month-1year):62.5mg/QID\nTarget Dose(1year-6years):125mg/QID\nTarget Dose(6year-12years):250mg/QID\nMax Dose: 4doses in 24hours',
                  ),
                ),
              );
            }
            if (index == 9) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Paracetamol syrup consentration(120mg/5ml)\nTarget Dose(2years-12years):10-15mg/kg\nMax Dose: 4doses in 24hours',
                  ),
                ),
              );
            }
            if (index == 10) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Paracetamol Drops consentration(100mg/1ml)\nTarget Dose(1day-1year):10-15mg/kg\nMax Dose: 4doses in 24hours',
                  ),
                ),
              );
            }
            if (index == 11) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Ibuprofen consentration(100mg/5ml)\nTarget Dose(1year-2years):50mg/TID\nTarget Dose(3year-7years):100mg/TID\nTarget Dose(8year-12years):200mg/TID\nMax Dose:2400mg/Day',
                  ),
                ),
              );
            }
            if (index == 12) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Chlorpheniramine Maleate consentration(2mg/5ml)\nTarget Dose(1month-2years):1mg/BD\nTarget Dose(2years-5years):1mg/TID\nTarget Dose(6years-12years):2mg/TID\nMax Dose(2Y-6Y):12mg/day Max Dose(12Y-18Y):24mg/day',
                  ),
                ),
              );
            }
            if (index == 13) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Actifed Syrup consentration(30mg/5ml)\nTarget Dose(2years-5years):2.5ml/TID\nTarget Dose(5years-12years):5ml/TID\nMax Dose:10ml 4times/day',
                  ),
                ),
              );
            }

            if (index == 14) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Promethazine HCI consentration(5mg/5ml)\nTarget Dose(2years-5years):5ml/BD\nTarget Dose(5years-10years):5-10ml/BD\nTarget Dose(10years-18years):10-20ml/BD',
                  ),
                ),
              );
            }
            if (index == 15) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Lactulose\nTarget Dose(1month-1year):2.5ml/BD\nTarget Dose(1year-5years):2.5-10ml/BD\nTarget Dose(5years-18years):5-20ml/BD',
                  ),
                ),
              );
            }
            if (index == 16) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Nystatin consentration(100K I.U/1ml)\nTarget Dose(1month baby):1ml/OD\nTarget Dose(older than 1month baby):1ml/OD\nTarget Dose(older than 18years):5ml/OD',
                  ),
                ),
              );
            }
            if (index == 17) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Ferrous Sulphate Drops consentration(125mg/1ml)\nTarget Dose(1month-12month):0.5-1.2ml/OD',
                  ),
                ),
              );
            }
            if (index == 18) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Multivitamin Syrup\nTarget Dose(above 4yeas):5ml/OD',
                  ),
                ),
              );
            }
            if (index == 19) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(
                    selected:
                        'Albendazole Suspension consentration(100mg/5ml)\nTarget Dose(1-2years):10ml and repeat after 7days\nTarget Dose(over 2years):20ml and repeat after 7days',
                  ),
                ),
              );
            }
            if (index == 666) {
              //6.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Resources(),
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              //      const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  img,
                  height: 120,
                  width: 140,
                ),
              ),
              // const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color.fromRGBO(245, 244, 240, 100),
       appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Welcome to Pedistric Dose",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Select the medication name:",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(2),
              children: [
                makeDashboardItem(
                    "resources link", "assets/images/صحتك99.png", 666),
                makeDashboardItem("Amoxicillin", "assets/images/صحتك99.png", 0),
                makeDashboardItem("Augmentin", "assets/images/صحتك99.png", 1),
                makeDashboardItem(
                    "Azithromycin", "assets/images/صحتك99.png", 2),
                makeDashboardItem("Cefuroxime", "assets/images/صحتك99.png", 3),
                makeDashboardItem("Cloxacillin", "assets/images/صحتك99.png", 4),
                makeDashboardItem("Cephalexin", "assets/images/صحتك99.png", 5),
                makeDashboardItem(
                    "Metronidazole", "assets/images/صحتك99.png", 6),
                makeDashboardItem(
                    "Erythromycin", "assets/images/صحتك99.png", 7),
                makeDashboardItem("Phenoxy\n methyl\npenicillin",
                    "assets/images/صحتك99.png", 8),
                makeDashboardItem(
                    "Paracetamol syrup", "assets/images/صحتك99.png", 9),
                makeDashboardItem(
                    "Paracetamol Drops", "assets/images/صحتك99.png", 10),
                makeDashboardItem("Ibuprofen", "assets/images/صحتك99.png", 11),
                makeDashboardItem("Chlorpheniramine\n       Maleate",
                    "assets/images/صحتك99.png", 12),
                makeDashboardItem(
                    "Actifed Syrup", "assets/images/صحتك99.png", 13),
                makeDashboardItem(
                    "Promethazine HCI", "assets/images/صحتك99.png", 14),
                makeDashboardItem("Lactulose", "assets/images/صحتك99.png", 15),
                makeDashboardItem("Nystatin", "assets/images/صحتك99.png", 16),
                makeDashboardItem(
                    "Ferrous Sulphate Drops", "assets/images/صحتك99.png", 17),
                makeDashboardItem(
                    "Multivitamin Syrup", "assets/images/صحتك99.png", 18),
                makeDashboardItem(
                    "Albendazole Suspension", "assets/images/صحتك99.png", 19),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
