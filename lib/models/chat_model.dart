import 'package:cloud_firestore/cloud_firestore.dart';

class Chat
{
  String otherPartyPic = "";
  String otherPartyName = "";
  String lastMessage= "";
  String lastMessageTime= "";
  String doctorId = "";
  String otherPartyToken = "";
  Chat(lastMessage,lastMessageTime,otherPartyPic,otherPartyName,doctorId,otherPartyToken)
  {
    this.lastMessage = lastMessage;
    this.lastMessageTime = lastMessageTime;
    this.otherPartyPic = otherPartyPic;
    this.otherPartyName = otherPartyName;
    this.doctorId = doctorId;
    this.otherPartyToken = otherPartyToken;
  }

}