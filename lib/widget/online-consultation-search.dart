import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sehetak2/widget/online_details.dart';

class OnlineConsultationSearch extends StatefulWidget {
  const OnlineConsultationSearch({Key key}) : super(key: key);

  @override
  State<OnlineConsultationSearch> createState() =>
      _OnlineConsultationSearchState();
}

class _OnlineConsultationSearchState extends State<OnlineConsultationSearch> {
  TextEditingController searchController = TextEditingController();
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor("#d9e1df"),
          actions: [],
          title: (Directionality(
            textDirection: TextDirection.ltr,
            child: TextField(
              controller: searchController,
              style: const TextStyle(
                fontSize: 15.0,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: HexColor("#d9e1df"),
                hintText: 'Search Doctor',
                contentPadding:
                    EdgeInsets.only(left: 14.0.w, bottom: 8.0.h, top: 8.0.h),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#d9e1df")),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#d9e1df")),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  inputText = val;
                  print(inputText);
                });
              },
            ),
          )),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('doctors')
                .where('name', isGreaterThanOrEqualTo: inputText)
                .snapshots(),
            builder:
                // ignore: missing_return
                (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot posts = snapshot.data.docs[index];
                  // children:
                  // snapshot.data.docs.map((DocumentSnapshot document) {
                  //   Map<String, dynamic> data =
                  //      document.data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return OnlineDetailes(
                          name: posts['name'],
                          images: posts['image'],
                          title: posts['title'],
                          description: posts['description'],
                          price: posts['price'],
                          rating: posts['rating'],
                          doctorId: snapshot.data.docs[index].reference.id,
                          doctorToken: snapshot.data.docs[index].data().containsKey('token')  ? posts['token'] : posts.reference.id,
                        );
                      }));
                    },
                    child: ListTile(
                      title: Text(posts['name']),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(posts['image']),
                      ),
                      subtitle: Text(posts['sr']),
                    ),
                  );
                  // }).toList();
                },
              );
            }),
      ),
    );
  }
}
