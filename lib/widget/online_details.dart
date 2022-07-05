import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sehetak2/screens/chat/VIews/ChatScreen.dart';
import 'package:sehetak2/screens/dshbord-home/dashboard_home.dart';

class OnlineDetailes extends StatelessWidget {
  String name;
  String images;
  String title;
  String description;
  String price;
  String doctorId;
  double rating;
  String doctorToken;
  OnlineDetailes(
      {this.name,
      this.images,
      this.title,
      this.description,
      this.price,
      this.rating,
      this.doctorId,
   this.doctorToken});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        // appBar: AppBar(
        //  toolbarHeight: 30,
        //  elevation: 0.0,
        //  backgroundColor: Colors.blue,
        // ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 35.h,
                  left: 14.w,
                ),
                child: InkWell(
                  child: Icon(Icons.arrow_back_ios_rounded,
                      size: 18.0, color: HexColor('#787575')),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Container(
              width: 350.w,
              height: 175.h,
              child: Image.network(images),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: HexColor('#25282B'),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12.h,
                left: 30.w,
              ),
              child: Container(
                height: 320.h,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About:',
                        style: TextStyle(
                          color: HexColor('#000000'),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16.h,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: HexColor('#C4C4C4'),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: HexColor('#C4C4C4'),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16.h,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Fees: $price',
                          style: TextStyle(
                            color: HexColor('#000000'),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  // top: 110.h,
                  ),
              child: RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                itemSize: 30,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // ignore: avoid_print
                  print(rating);
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 34.h,
                    left: 60.w,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 250, height: 56),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#80B1FE'),
                      ),
                      child: const Icon(Icons.messenger),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatScreen(name, images, Dashboard.uid,doctorId,doctorToken)));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
