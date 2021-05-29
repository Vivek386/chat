import 'package:chat_app/SignIn.dart';
import 'package:flutter/material.dart';
//import 'package:country_calling_code_picker/picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:chat_app/VerifyOtp.dart';


class SendOtp extends StatefulWidget {
  @override
  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _mobilecontroller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Phone Authentication'),
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60),
                Image.asset("assets/images/SendOTP.png"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enter your Phone Number",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("We will send you the 6 digit verification code",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
                  ],
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 3.0,
                  child: Container(
                    color: Colors.white54,
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _mobilecontroller,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      //inputBorder: OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 120, top: 10),
                    width: double.maxFinite,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    child: Text("GENERATE OTP",style: TextStyle(color: Colors.white,fontSize: 20)),
                  ),
                  onTap: (){
                    (formKey.currentState.validate())
                        ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(_mobilecontroller.text)))
                        :print("Entered Number is not valid!");
                  },
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
                // RaisedButton(
                //   onPressed: () {
                //     (formKey.currentState.validate())
                //         ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(_mobilecontroller.text)))
                //         :print("Entered Number is not valid!");
                //   },
                //   child: Text('Next'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    _mobilecontroller?.dispose();
    super.dispose();
  }
}


