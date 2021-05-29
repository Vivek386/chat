import 'package:chat_app/HomePage.dart';
import 'package:chat_app/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'dart:convert';

// the most important implementation to get the otp screen .....implementation 'androidx.browser:browser:1.2.0'..... in app level build gradle file..
class OTPScreen extends StatefulWidget {
  final String mobile;
  OTPScreen(this.mobile);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isCodeSent = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      // appBar: AppBar(
      //   title: Text('OTP Verification'),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.asset("assets/images/VerifyOTP.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("OTP Verification",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter the OTP sent to" + " " + widget.mobile ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
                ],
              ),
              SizedBox(height: 20),
              // Container(
              //   margin: EdgeInsets.only(top: 40),
              //   child: Center(
              //     child: Text('Enter the 6 digit code here',
              //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              //     ),
              //   ),
              // ),
              //Below code is just copied from https://pub.dev/packages/pinput/example
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 6,
                  textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          // var api = APIService(isLogin: false);
                          // var token = api.getAccessToken(FirebaseAuth.instance.currentUser.phoneNumber, FirebaseAuth.instance.currentUser.uid);
                          // if("$token" !=  null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()));
                          // }else{
                          //   FocusScope.of(context).unfocus();
                          //   _scaffoldkey.currentState
                          //       .showSnackBar(SnackBar(content: Text('Something Went Wrong')));
                          // }
                        }
                      }
                      );
                    } catch (e) {
                      print(e);
                       FocusScope.of(context).unfocus();
                      // _scaffoldkey.currentState
                      //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Invalid OTP'),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 40),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),

                Text("or SignIn using"),

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
              SizedBox(height: 15),
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
                        IconButton(
                            icon: Icon(Icons.email), onPressed: () {}),
                        Text(
                          "Email/Password",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SignIn();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  //below code is the most important code for phone authentication using otp,
  /// referred from https://www.youtube.com/results?search_query=Flutter+phone+authentication by Lazy Techno.
  /// refer this page https://firebase.flutter.dev/docs/auth/phone/

  /// On native platforms, the user's phone number must be first verified and
  /// then the user can either sign-in or link their account with a PhoneAuthCredential.
  //
  /// First you must prompt the user for their phone number. Once provided, call the verifyPhoneNumber() method:
  //
  /// await FirebaseAuth.instance.verifyPhoneNumber(
  /// phoneNumber: '+44 7123 123 456',
  /// verificationCompleted: (PhoneAuthCredential credential) {},
  /// verificationFailed: (FirebaseAuthException e) {},
  /// codeSent: (String verificationId, int resendToken) {},
  /// codeAutoRetrievalTimeout: (String verificationId) {},
  /// );
  _verifyPhone() async {
    print("verify_phone");
    if (mounted)
      setState(() {
        isCodeSent = true;
      });
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91${widget.mobile}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }
            });

          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
          },
          codeSent: (String verficationID, int resendToken) {
            setState(() {
              _verificationCode = verficationID;
            });
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            setState(() {
              _verificationCode = verificationID;
            });
          },
          timeout: Duration(seconds: 120));
    }catch(e){
      print(e.message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}


