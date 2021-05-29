import 'package:chat_app/SendOtp.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Helper/Decoration.dart';
import 'package:chat_app/Helper/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/HomePage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'SignUp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool isLoggedIn = false;
  _googlelogin()async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        isLoggedIn = true;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return MyHomePage();
      }));
    }catch(err){
     print(err);
    }
  }

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
                SizedBox(height: 50),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 50, color: Colors.black54),
                ),
                SizedBox(height: 45),
                Text(
                  "Welcome back",
                  style: TextStyle(fontSize: 35, color: Colors.black38),
                ),
                Text(
                  "please login",
                  style: TextStyle(fontSize: 35, color: Colors.black38),
                ),
                Text(
                  "to your account",
                  style: TextStyle(fontSize: 35, color: Colors.black38),
                ),
                SizedBox(height: 30),
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
                  padding: const EdgeInsets.only(top: 10),
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
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  onTap: () async{
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        /// to do
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage();
                        }));
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
                          content: const Text(
                              'Entered email and Password are invalid!'),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    !isLoggedIn
                        ?InkWell(
                        onTap: () {
                       _googlelogin();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(40),
                            color: const Color(0xFFEA4336),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      )
                          :Container(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SendOtp();
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(40),
                          color: Colors.lime,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.phone_android),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () => _googlelogin(),
                    //   child: Container(
                    //     padding: const EdgeInsets.all(12),
                    //     decoration: BoxDecoration(
                    //       borderRadius:
                    //       BorderRadius.circular(40),
                    //       color: const Color(0xFFEA4336),
                    //     ),
                    //     child: const Icon(
                    //       FontAwesomeIcons.mobile,
                    //       color: Colors.white,
                    //       size: 24.0,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // GestureDetector(
                //   child: Card(
                //     elevation: 3.0,
                //     child: Container(
                //       width: double.maxFinite,
                //       height: 40,
                //       color: Colors.grey.shade200,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           IconButton(
                //               icon: Icon(Icons.phone_android), onPressed: () {}),
                //           Text(
                //             "Login with OTP",
                //             style: TextStyle(fontSize: 20, color: Colors.black54),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context){
                //       return SendOtp();
                //     }));
                //   },
                // ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SignUp();
                        }));
                      },
                      child: Text(
                        "Sign Up",
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
