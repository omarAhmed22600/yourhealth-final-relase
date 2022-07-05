import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sehetak2/screens/dshbord-home/dashboard_home.dart';
import 'package:sehetak2/widget/clinic-search.dart';
import 'package:sehetak2/widget/online-consultation-search.dart';

import '../components/applocal.dart';
import 'OnlineConsultation.dart';
import 'clinic-details.dart';
import 'online_details.dart';

class ClinicExamination extends StatefulWidget {
  String name;
  String photoUrl;
  ClinicExamination(this.name,this.photoUrl, {Key key}) : super(key: key);

  @override
  _ClinicExaminationState createState() => _ClinicExaminationState();
}

class _ClinicExaminationState extends State<ClinicExamination>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  TextEditingController searchController = TextEditingController();
  QuerySnapshot<Map<String, dynamic>> snapshotData;
  bool isExcecuted = false;

  // ignore: unused_field
  @override
  void initState() {
    tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  String search = '';

  CollectionReference getAllDoctors =
      FirebaseFirestore.instance.collection("doctors");

  CollectionReference searchAllDoctors =
      FirebaseFirestore.instance.collection("doctors");

  Query<Map<String, dynamic>> getDermDoctors = FirebaseFirestore.instance
      .collection("doctors")
      .where("specialty", isEqualTo: "Dermatology");

  Query<Map<String, dynamic>> getDentDoctors = FirebaseFirestore.instance
      .collection("doctors")
      .where("specialty", isEqualTo: "Dentistry");

  Query<Map<String, dynamic>> getNeurDoctors = FirebaseFirestore.instance
      .collection("doctors")
      .where("specialty", isEqualTo: "Neurology");

  Query<Map<String, dynamic>> getOrthDoctors = FirebaseFirestore.instance
      .collection("doctors")
      .where("specialty", isEqualTo: "Orthopedics");

  Query<Map<String, dynamic>> getOpthDoctors = FirebaseFirestore.instance
      .collection("doctors")
      .where("specialty", isEqualTo: "Ophthalmology");

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        backgroundColor: HexColor("#f5fcfd"),
        appBar: AppBar(
          backgroundColor: HexColor("#f5fcfd"),
          elevation: 0.0,
          leading:  IconButton( onPressed: () {
            Navigator.of(context).pop(false);
          },
              icon: const Icon(Icons.arrow_back,color: Colors.grey,)),
          title: Column(
            children: [
               Text(
                "${getLang(context, "Hello")}",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
              ),
              SizedBox(width: 20.w),
              Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                ),
                child: Text(widget.name+"!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    )),
              )
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 33.0.w,
                top: 17.0.h,
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    widget.photoUrl,
                                  ),
            )
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 30.0.w,
                top: 30.0.h,
                right: 30.0.w,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 311, height: 42),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor('#d9e1df'),
                  ),
                  label: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${getLang(context, "Search Doctor")}",
                        style: TextStyle(color: HexColor("#898a8a"))),
                  ),
                  icon: Icon(Icons.search, color: HexColor("#898a8a")),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ClinicSearch();
                    }));
                  },
                ),
              ),
              /* new Directionality(
                textDirection: TextDirection.ltr,
                child: new TextField(
                  controller: searchController,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const OnlineSearch();
                    }));
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: HexColor("#898a8a")),
                    filled: true,
                    fillColor: HexColor("#d9e1df"),
                    hintText: 'Search Doctor',
                    contentPadding: EdgeInsets.only(
                        left: 14.0.w, bottom: 8.0.h, top: 8.0.h),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#d9e1df")),
                      borderRadius: new BorderRadius.circular(10.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#d9e1df")),
                        borderRadius: new BorderRadius.circular(10.7)),
                  ),
                ),
              ),*/
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              padding: EdgeInsets.only(
                top: 29.h,
                left: 30.w,
              ),
              child: Text(
                "${getLang(context, "Doctors")}",
                style: TextStyle(
                  color: HexColor("#000000"),
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                    isScrollable: true,
                    tabs:  [
                      Tab(text: "${getLang(context, "All Doctors")}"),
                      Tab(text:"${getLang(context, "Dermatology")}"),
                      Tab(text:"${getLang(context, "Dentistry")}"),
                      Tab(text:"${getLang(context, "Neurology")}"),
                      Tab(text:"${getLang(context, "Orthopedics")}"),
                      Tab(text:"${getLang(context, "Ophthalmology")}"),
                    ]),
              ),
            ),
            Container(
                width: double.maxFinite,
                height: 285.h,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    //-----------------------
                    Container(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 30.w,
                      ),
                      alignment: AlignmentDirectional.topStart,
                      child: StreamBuilder(
                          stream: getAllDoctors.snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Error");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Waiting");
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    DocumentSnapshot posts =
                                        snapshot.data.docs[i];
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) {
                                                      return ClinicDetailes(
                                                        name: posts[
                                                        'name'],
                                                        images: posts[
                                                        'image'],
                                                        title: posts[
                                                        'title'],
                                                        description: posts[
                                                        'description'],
                                                        price: posts[
                                                        'price'],
                                                        rating: posts[
                                                        'rating'],
                                                      );
                                                    }));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 140.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          posts['image']),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: HexColor('#80B1FE'),
                                                ),
                                              ),
                                              Container(
                                                width: 180.w,
                                                height: 115.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: HexColor('#FFFFFF'),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 14,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Dr. ${posts['name']}',
                                                          style: TextStyle(
                                                            color:
                                                                HexColor('#000000'),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      posts['sr'],
                                                      style: TextStyle(
                                                        color:
                                                            HexColor('#7c7a77'),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 11,
                                                            left: 27,
                                                          ),
                                                          child:
                                                              RatingBar.builder(
                                                            initialRating:
                                                                posts['rating'],
                                                            minRating: 1,
                                                            itemSize: 15,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              // ignore: avoid_print
                                                              print(rating);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                      ],
                                    );
                                    // Text(
                                    //   '${snapshot.data.docs[i].data()['name']}');
                                  });
                            }
                            return Text("Loading");
                          }),
                    ),
                    //__________________________________2
                    Container(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 30.w,
                      ),
                      alignment: AlignmentDirectional.topStart,
                      child: StreamBuilder(
                          stream: getDermDoctors.snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Error");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Waiting");
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, i) {
                                    DocumentSnapshot posts =
                                        snapshot.data.docs[i];
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) {
                                                      return ClinicDetailes(
                                                        name: posts[
                                                        'name'],
                                                        images: posts[
                                                        'image'],
                                                        title: posts[
                                                        'title'],
                                                        description: posts[
                                                        'description'],
                                                        price: posts[
                                                        'price'],
                                                        rating: posts[
                                                        'rating'],
                                                      );
                                                    }));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 140.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          posts['image']),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: HexColor('#80B1FE'),
                                                ),
                                              ),
                                              Container(
                                                width: 180.w,
                                                height: 115.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: HexColor('#FFFFFF'),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        top: 14,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Dr. ${posts['name']}',
                                                          style: TextStyle(
                                                            color:
                                                            HexColor('#000000'),
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      posts['sr'],
                                                      style: TextStyle(
                                                        color:
                                                        HexColor('#7c7a77'),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                            top: 11,
                                                            left: 27,
                                                          ),
                                                          child:
                                                          RatingBar.builder(
                                                            initialRating:
                                                            posts['rating'],
                                                            minRating: 1,
                                                            itemSize: 15,
                                                            direction:
                                                            Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                            const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              // ignore: avoid_print
                                                              print(rating);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                      ],
                                    );
                                    // Text(
                                    //   '${snapshot.data.docs[i].data()['name']}');
                                  });
                            }
                            return Text("Loading");
                          }),
                    ),
                    //__________________________________3
                    Container(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 30.w,
                      ),
                      alignment: AlignmentDirectional.topStart,
                      child: StreamBuilder(
                          stream: getDentDoctors.snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Error");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Waiting");
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, i) {
                                    DocumentSnapshot posts =
                                        snapshot.data.docs[i];
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) {
                                                      return ClinicDetailes(
                                                        name: posts[
                                                        'name'],
                                                        images: posts[
                                                        'image'],
                                                        title: posts[
                                                        'title'],
                                                        description: posts[
                                                        'description'],
                                                        price: posts[
                                                        'price'],
                                                        rating: posts[
                                                        'rating'],
                                                      );
                                                    }));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 140.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          posts['image']),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: HexColor('#80B1FE'),
                                                ),
                                              ),
                                              Container(
                                                width: 180.w,
                                                height: 115.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: HexColor('#FFFFFF'),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        top: 14,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Dr. ${posts['name']}',
                                                          style: TextStyle(
                                                            color:
                                                            HexColor('#000000'),
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      posts['sr'],
                                                      style: TextStyle(
                                                        color:
                                                        HexColor('#7c7a77'),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                            top: 11,
                                                            left: 27,
                                                          ),
                                                          child:
                                                          RatingBar.builder(
                                                            initialRating:
                                                            posts['rating'],
                                                            minRating: 1,
                                                            itemSize: 15,
                                                            direction:
                                                            Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                            const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              // ignore: avoid_print
                                                              print(rating);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                      ],
                                    );
                                    // Text(
                                    //   '${snapshot.data.docs[i].data()['name']}');
                                  });
                            }
                            return Text("Loading");
                          }),
                    ),
                    //-----------------------------4
                    Container(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 30.w,
                      ),
                      alignment: AlignmentDirectional.topStart,
                      child: StreamBuilder(
                          stream: getNeurDoctors.snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Error");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Waiting");
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, i) {
                                    DocumentSnapshot posts =
                                        snapshot.data.docs[i];
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) {
                                                      return ClinicDetailes(
                                                        name: posts[
                                                        'name'],
                                                        images: posts[
                                                        'image'],
                                                        title: posts[
                                                        'title'],
                                                        description: posts[
                                                        'description'],
                                                        price: posts[
                                                        'price'],
                                                        rating: posts[
                                                        'rating'],
                                                      );
                                                    }));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 140.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          posts['image']),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: HexColor('#80B1FE'),
                                                ),
                                              ),
                                              Container(
                                                width: 180.w,
                                                height: 115.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: HexColor('#FFFFFF'),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        top: 14,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Dr. ${posts['name']}',
                                                          style: TextStyle(
                                                            color:
                                                            HexColor('#000000'),
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      posts['sr'],
                                                      style: TextStyle(
                                                        color:
                                                        HexColor('#7c7a77'),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                            top: 11,
                                                            left: 27,
                                                          ),
                                                          child:
                                                          RatingBar.builder(
                                                            initialRating:
                                                            posts['rating'],
                                                            minRating: 1,
                                                            itemSize: 15,
                                                            direction:
                                                            Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                            const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              // ignore: avoid_print
                                                              print(rating);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                      ],
                                    );
                                    // Text(
                                    //   '${snapshot.data.docs[i].data()['name']}');
                                  });
                            }
                            return Text("Loading");
                          }),
                    ),
                    //--------------------------------5
                    Container(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 30.w,
                      ),
                      alignment: AlignmentDirectional.topStart,
                      child: StreamBuilder(
                          stream: getOrthDoctors.snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Error");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Waiting");
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, i) {
                                    DocumentSnapshot posts =
                                        snapshot.data.docs[i];
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) {
                                                      return ClinicDetailes(
                                                        name: posts[
                                                        'name'],
                                                        images: posts[
                                                        'image'],
                                                        title: posts[
                                                        'title'],
                                                        description: posts[
                                                        'description'],
                                                        price: posts[
                                                        'price'],
                                                        rating: posts[
                                                        'rating'],
                                                      );
                                                    }));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 140.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          posts['image']),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: HexColor('#80B1FE'),
                                                ),
                                              ),
                                              Container(
                                                width: 180.w,
                                                height: 115.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: HexColor('#FFFFFF'),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        top: 14,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Dr. ${posts['name']}',
                                                          style: TextStyle(
                                                            color:
                                                            HexColor('#000000'),
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      posts['sr'],
                                                      style: TextStyle(
                                                        color:
                                                        HexColor('#7c7a77'),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                            top: 11,
                                                            left: 27,
                                                          ),
                                                          child:
                                                          RatingBar.builder(
                                                            initialRating:
                                                            posts['rating'],
                                                            minRating: 1,
                                                            itemSize: 15,
                                                            direction:
                                                            Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                            const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              // ignore: avoid_print
                                                              print(rating);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                      ],
                                    );
                                    // Text(
                                    //   '${snapshot.data.docs[i].data()['name']}');
                                  });
                            }
                            return Text("Loading");
                          }),
                    ),
                    //------------------------------6
                    Container(
                      padding: EdgeInsets.only(
                        top: 24.h,
                        left: 30.w,
                      ),
                      alignment: AlignmentDirectional.topStart,
                      child: StreamBuilder(
                          stream: getOpthDoctors.snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Error");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Waiting");
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, i) {
                                    DocumentSnapshot posts =
                                        snapshot.data.docs[i];
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) {
                                                      return ClinicDetailes(
                                                        name: posts[
                                                        'name'],
                                                        images: posts[
                                                        'image'],
                                                        title: posts[
                                                        'title'],
                                                        description: posts[
                                                        'description'],
                                                        price: posts[
                                                        'price'],
                                                        rating: posts[
                                                        'rating'],
                                                      );
                                                    }));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 140.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          posts['image']),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: HexColor('#80B1FE'),
                                                ),
                                              ),
                                              Container(
                                                width: 180.w,
                                                height: 115.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: HexColor('#FFFFFF'),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        top: 14,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Dr. ${posts['name']}',
                                                          style: TextStyle(
                                                            color:
                                                            HexColor('#000000'),
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      posts['sr'],
                                                      style: TextStyle(
                                                        color:
                                                        HexColor('#7c7a77'),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                            top: 11,
                                                            left: 27,
                                                          ),
                                                          child:
                                                          RatingBar.builder(
                                                            initialRating:
                                                            posts['rating'],
                                                            minRating: 1,
                                                            itemSize: 15,
                                                            direction:
                                                            Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                            const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              // ignore: avoid_print
                                                              print(rating);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20.0),
                                      ],
                                    );
                                    // Text(
                                    //   '${snapshot.data.docs[i].data()['name']}');
                                  });
                            }
                            return Text("Loading");
                          }),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                left: 31.w,
                right: 20.w,
              ),
              child: Container(
                  // height: 129.h,
                  height: 129.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: HexColor("#FFFFFF"),
                  ),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.h,
                            // left: 18.w,
                            //  right: 2.w,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 18.w,
                                    right: 2.w,
                                  ),
                                  child: Text(
                                    "${getLang(context, "Instant Appointment")}",
                                    style: TextStyle(
                                      color: HexColor('#000000'),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 18.w,
                                  right: 2.w,
                                ),
                                child: Text(
                                  "${getLang(context, "If you want to book an \n online consultation    \n     just click here")}",
                                  style: TextStyle(
                                    color: HexColor('#7c7a77'),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 5.h,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 70, height: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: HexColor('#80B1FE'),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    ),
                                    child: Text("${getLang(context, "Book")}",),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return OnlineConsultation(widget.name,widget.photoUrl);                                          }));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                              "https://img.freepik.com/free-vector/doctor-examining-patient-clinic-illustrated_23-2148856559.jpg"),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
