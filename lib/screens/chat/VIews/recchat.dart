import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sehetak2/screens/chat/Services/auth.dart';
import 'package:sehetak2/screens/chat/Services/database.dart';
import 'package:sehetak2/screens/chat/VIews/ChatScreen.dart';
import 'package:sehetak2/screens/chat/helperfunctions/shardpref_helper.dart';

class recchat extends StatefulWidget {
  const recchat({Key key}) : super(key: key);

  @override
  _recchatState createState() => _recchatState();
}

class _recchatState extends State<recchat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isSearching = false;
  String myName, myProfilePic, myEmail;
  Stream usersStream, chatRoomsStream;
  String currentUserId;
  AuthMethods authProvider;
  recchat homeProvider;
  TextEditingController searchUsernameEditingController = TextEditingController();




  void getData() async {
    User user = _auth.currentUser;
    currentUserId = user.uid;
    print('user.displayName ${user.displayName}');
    print('user.photoURL ${user.photoURL}');
    final DocumentSnapshot userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        myName = userDoc.get('name');
        myEmail = user.email;
        myProfilePic = userDoc.get('imageUrl');
      });
    }
    // print("name $_name");
  }
  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseMethods()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return ChatRoomListTile(ds["lastMessage"], ds.id, myName,currentUserId);
            })
            : const Center(child: const CircularProgressIndicator());
      },
    );
  }

  Widget searchListUserTile({String profileUrl, name, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(myName, name);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myEmail, email , myName ,name]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ChatScreen( name ,profileUrl,currentUserId)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                profileUrl,
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(email)])
          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return searchListUserTile(
                profileUrl: ds["imageUrl"],
                name: ds["name"],
                email: ds["email"]
            );
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getData();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffb7dcea),Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          brightness: Brightness.dark,
          //remove bcakgroundcolor from appbar
          backgroundColor: Colors.transparent,
          //remove shadwo frome app bar
          elevation: 0 ,
          toolbarHeight: 65,
          flexibleSpace:Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30) ),
              gradient: LinearGradient(
                colors: [HexColor("#80b1fe"),HexColor("#3D50E7")],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
        ),
          title: const Text('Recent Chats'),

        ),
        body: WillPopScope(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        isSearching
                            ? GestureDetector(
                          onTap: () {
                            isSearching = false;
                            searchUsernameEditingController.text = "";
                            setState(() {});
                          },
                          child: const Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Icon(Icons.arrow_back_ios)),
                        )
                            : Container(),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                color: Colors.white.withOpacity(0.25)
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                      controller: searchUsernameEditingController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none, hintText: "Search..."),
                                    )),
                                GestureDetector(
                                    onTap: () {
                                      if (searchUsernameEditingController.text != "") {
                                        onSearchBtnClick();
                                      }
                                    },
                                    child: const Icon(Icons.search))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    isSearching ? searchUsersList() : chatRoomsList()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername,currentUid;
  const ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername,this.currentUid);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ChatScreen(name ,profilePicUrl,widget.currentUid)));
      },
      child: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: profilePicUrl != "" ? NetworkImage(profilePicUrl ,) :
                  const AssetImage("assets/lottie/user.png"),
                ) ,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,

                    ),
                    const SizedBox(height: 3),
                    Text(widget.lastMessage,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,

                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: Colors.grey.withOpacity(0.2)
        ),
      ),
    );
  }
}