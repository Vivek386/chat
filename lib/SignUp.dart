import 'package:chat_app/SendOtp.dart';
import 'package:chat_app/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Helper/Decoration.dart';
import 'package:chat_app/Helper/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/HomePage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 50, color: Colors.black54),
                ),
                SizedBox(height: 45),
                Text(
                  "Let's get",
                  style: TextStyle(fontSize: 35, color: Colors.black38),
                ),
                Text(
                  "you on board !",
                  style: TextStyle(fontSize: 35, color: Colors.black38),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),

                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 137, top: 8),
                    width: double.maxFinite,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.lightBlueAccent,
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        /// to do
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage();
                        }));
                        //Navigator.pushNamed(context, ChatScreen.id);
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('Entered email is already registered!'),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 15),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Divider(
                          color: Colors.black,
                          height: 50,
                        )),
                  ),

                  Text("OR"),

                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Divider(
                          color: Colors.black,
                          height: 50,
                        )),
                  ),
                ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Card(
                    elevation: 3.0,
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(Icons.phone_android), onPressed: (){}),
                          Text("Login with OTP",style: TextStyle(fontSize: 20,color: Colors.black54),),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SendOtp();
                    }));
                  },
                ),
                 SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SignIn();
                        }));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
