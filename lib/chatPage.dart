import 'package:chat_app/SendOtp.dart';
import 'package:chat_app/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Models/chatUsersModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'conversationList.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool isLoggedIn = false;
  // _googlelogin()async{
  //   try{
  //     await _googleSignIn.signIn();
  //     setState(() {
  //       isLoggedIn = true;
  //     });
  //     Navigator.push(context, MaterialPageRoute(builder: (context){
  //       return MyHomePage();
  //     }));
  //   }catch(err){
  //     print(err);
  //   }
  // }

  _googlelogout()async{
    try{
      await _googleSignIn.signOut();
      setState(() {
        isLoggedIn = false;
      });
    }catch(err){
      print(err);
    }
  }
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Ashley", message: "I am not vella anymore", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV5bETvsQ2xjm5_KV-XPLIuaxynx1-0rN50QFxUiJtr4mOoCovNH_zcBAibqhdiYxHwug&usqp=CAU", time: "Now"),
    ChatUsers(name: "Glady's Murphy", message: "That's Great", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOKX-W20Iui7I85-dHUZm3XmiAda5gflULCljj29n5iWg2n5G4YD8k_CI-sUbse8h06pI&usqp=CAU", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry", message: "Hey where are you?", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmoNwonsEQMDbSxj-LxEy2RqOwbLl-aygsTplKFkDjaAWt_o6lMEVSDz1173E5kGrA6ls&usqp=CAU", time: "31 Mar"),
    ChatUsers(name: "Philip Fox", message: "Busy! Call me in 20 mins", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBg08bjIJCVrKIVvyu5D5KmSU007Pg1H7O0ma6HeUQKrZRyyC8PHonG-yMsW1DmWAfaww&usqp=CAU", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", message: "Thankyou, It's awesome", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWHd5gbED4mMSyQ0_uwIqAJL3B-oOrXwcpTYiFNKp7Lb9Fk60ETXjCq5ac7XBMtUGBSIM&usqp=CAU", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", message: "will update you in evening", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGzUHqCVuOM3im9SSlMbxLwQxHvQp3DILmJ_HYZMmFSbWnHVVXYVpRyXdh0OkIQ63gx6Y&usqp=CAU", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", message: "Can you please share the file?", imageUrl: "images/7.jpg", time: "24 Feb"),
    ChatUsers(name: "John Wick", message: "How are you?", imageUrl: "images/8.jpg", time: "18 Feb"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Colors.pink,size: 20,),
                          SizedBox(width: 2,),
                          Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    IconButton(icon: Icon(Icons.logout), onPressed: (){
                      _googlelogout();
                      Navigator.pushReplacement(
                          context,  MaterialPageRoute(builder: (context){
                        return WelcomeScreen();
                      }));
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600,size: 20),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].message,
                  imageUrl: chatUsers[index].imageUrl,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
