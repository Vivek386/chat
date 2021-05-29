import 'package:chat_app/chatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  List<User>RegisteredUsers = [];

  void getCurrentUser() async{
    final User user =  await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        RegisteredUsers.add(loggedInUser);
        print(RegisteredUsers.length.toString());
        RegisteredUsers.forEach((e) {print(e.phoneNumber); });
        //print( "Registered phone number" + loggedInUser.phoneNumber);
        //print("Current email id " + loggedInUser.email);
        //print(loggedInUser.uid);
        //print(loggedInUser.displayName);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          items: [
          BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "Chat",
          ),
          BottomNavigationBarItem(
           icon: Icon(Icons.group_work),
           label: "Channels",
           ),
           BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile",
              ),
        ]
      ),
    );
  }
}
