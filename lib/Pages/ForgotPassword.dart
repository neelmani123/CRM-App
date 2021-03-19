//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();TextEditingController email=new TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String email_shared;

  Future getStringEmail()async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    email_shared=pref.getString('email_id');
  }

  Future<void>resetForgotPassword()async
  {
    await _firebaseAuth.sendPasswordResetEmail(email: email.text);
    Toast.show("Check Your Mail", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    print(_firebaseAuth.currentUser);
    Navigator.pushReplacement(context, MaterialPageRoute(builder:  (BuildContext context)=>LoginPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringEmail();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.deepPurpleAccent),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset("assets/logo.png",height: 100,width: 150,),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("Forgot Password",style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20.0),
                  child: Container(
                    child: TextFormField(
                      controller: email,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Email'
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 60,// specific value
                        child:  RaisedButton(
                            child: Text("Send Mail",style: TextStyle(fontSize: 20.0),),
                            textColor: Color(0xFFffffff),
                            color: Colors.deepPurpleAccent,
                            onPressed: () {
                              resetForgotPassword();
                              /*if(mobileNumber.text.length==0)
                              {
                                Toast.show("Enter Valid Mobile no", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                              }
                              else
                              {
                                sendOtp();
                              }*/
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(
                                    7.0))),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(height: 92,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/bg1.png",width: 150,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
