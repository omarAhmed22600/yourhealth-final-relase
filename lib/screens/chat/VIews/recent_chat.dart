import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sehetak2/models/chat_model.dart';
import 'package:collection/src/iterable_extensions.dart';

import 'package:sehetak2/screens/chat/Services/database.dart';
import 'package:sehetak2/screens/chat/VIews/ChatScreen.dart';
import 'package:sehetak2/screens/dshbord-home/dashboard_home.dart';
import 'package:sehetak2/widget/dashboard.dart';

import '../../../consts/colors.dart';

class RecentChats extends StatefulWidget {
  static const routeName = "/recent_chat";
  const RecentChats({Key key}) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  List<Chat> chats = [];
  int length;
  bool isDataLoaded = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     await getChats();
     isDataLoaded = true;
    });
    setState(() {});

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
            ),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: MySearchDelegate(chats: chats)
              );
            },
          ),
        ],
        elevation: 5.0,
        backgroundColor: ColorsConsts.primaryColor,
        toolbarHeight: 65.0,
        title: const Center(child: const Text("Recent Chats"
        )),
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: ConditionalBuilder(
        condition: chats.isNotEmpty && isDataLoaded,
          builder: (build) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                itemBuilder: (context,index) => chatBuilder(index),
                separatorBuilder: (context,index) => Expanded(
                  child: Divider(
                    thickness: 2.0,
                    color: Colors.black,
                  ),
                ),
                itemCount: chats.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
              ),
          ),
        fallback: (build) => const Center(child: const CircularProgressIndicator(color: Colors.blue,)),
      ),
    );
  }

  getChats() async
  {
    FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("userid-docid", arrayContains: Dashboard.uid)
        .snapshots().listen((event) {
          print("=====================================");
          print(DashboardTab.uid);
          print(Dashboard.uid);
          print("=====================================");
          event.docs.forEach((element) {
            int indexOfOtherParty = 0;
            String otherPartyId=element.data()['userid-docid'][indexOfOtherParty];
            String otherPartyToken = element.data()['usertoken-doctoken'][indexOfOtherParty];
            if(otherPartyId == DashboardTab.uid)
              {
                indexOfOtherParty = 1;
                otherPartyId=element.data()['userid-docid'][indexOfOtherParty];

              }
            otherPartyToken = element.data()['usertoken-doctoken'][indexOfOtherParty];
            String otherPartyName = element.data()['username-docname'][indexOfOtherParty];
            String otherPartyPic = element.data()["userpic-docpic"][indexOfOtherParty];
            DateTime h = (element.data()['lastMessageSendTs'] as Timestamp).toDate();
            String hours = new DateFormat.jm().format(h);
            if (h.day != DateTime.now().day)
              {
                if  ((h.day == DateTime.now().day-1 && h.month==DateTime.now().month && h.year == DateTime.now().year) ||( DateTime.now().day == 1 && h.month == DateTime.now().month-1 && h.year == DateTime.now().year) )
                  {
                    hours = "Yesterday";
                  }
                else
                  {
                    hours = h.day.toString()+"/"+h.month.toString()+"/"+h.year.toString();
                  }
              }

            chats.add( new Chat(element.data()['lastMessage'],hours,otherPartyPic,otherPartyName,otherPartyId,otherPartyToken));
          });
          setState(() {});
    });
  }

  Widget chatBuilder(index)
  {

    return InkWell(
      onTap: ()
      {
        print(chats[index].doctorId);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(chats[index].otherPartyName,chats[index].otherPartyPic,Dashboard.uid,chats[index].doctorId,chats[index].otherPartyToken)));

        },
      child: Container(
        decoration: BoxDecoration(
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundImage: chats[index].otherPartyPic != null ? NetworkImage(chats[index].otherPartyPic) : const AssetImage("assets/lottie/user.png"),
              ),
              const SizedBox(width: 10.0,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chats[index].otherPartyName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text(chats[index].lastMessage,overflow: TextOverflow.ellipsis,maxLines: 1)),
                        const SizedBox(width: 15.0,),
                        Text(chats[index].lastMessageTime),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate
{
  List<Chat> chats;
  List<String> names;
  MySearchDelegate({this.chats})
  {
    names=buildNames();
  }

  @override
  List<Widget> buildActions(BuildContext context) => [IconButton(
    icon: const Icon(Icons.clear),
    onPressed: (){
      query = '';
    },
  )];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back)
  );

  @override
  Widget buildResults(BuildContext context)  => const SizedBox();

  @override
  Widget buildSuggestions(BuildContext context)
  {
    List<int> suggestions = [];
    names.forEachIndexed((index, element){
      final String result = element.toLowerCase();
      final String input  = query.toLowerCase();
      result.contains(input) ? suggestions.add(index) : null;
    });
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 10.0,),
          ListView.separated(
            itemBuilder: (context,index) {
              final int suggestionIndex = suggestions[index];

              if(suggestionIndex != null) {
                return chatBuilder(suggestionIndex, context);
              }
            },
            separatorBuilder: (context,index) => Expanded(
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ),
            itemCount: suggestions.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
  Widget chatBuilder(index, BuildContext context)
  {

    return InkWell(
      onTap: ()
      {
        print(chats[index].doctorId);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(chats[index].otherPartyName,chats[index].otherPartyPic,Dashboard.uid,chats[index].doctorId,chats[index].otherPartyToken)));

      },
      child: Container(
        decoration: BoxDecoration(
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: chats[index].otherPartyPic != null ? NetworkImage(chats[index].otherPartyPic) : const AssetImage("assets/lottie/user.png"),
              ),
              const SizedBox(width: 10.0,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chats[index].otherPartyName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text(chats[index].lastMessage,overflow: TextOverflow.ellipsis,maxLines: 1)),
                        const SizedBox(width: 15.0,),
                        Text(chats[index].lastMessageTime),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<String> buildNames()
  {
    List<String> names = [];
    for (var element in chats) {
      names.add(element.otherPartyName);
    }
    return names;
  }
}
