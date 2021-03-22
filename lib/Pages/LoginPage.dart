import 'dart:convert';
import 'dart:io';
import 'package:crmapp/Api/ApiHandler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'DashBoard.dart';
import 'ForgotPassword.dart';
import 'package:toast/toast.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/SignUpPage.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/DashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final fromKey=new GlobalKey<FormState>();
  TextEditingController email=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  //final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
 @override
  void initState() {
   super.initState();
   // FirebaseCrashlytics.instance.crash();
 }

 //Add Email Id in shared prefrence...
  Future addEmail()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString('email_id', email.text);
  }

  void validateAndSave(){
   final form=fromKey.currentState;
   if(form.validate())
   {
     print('Form is valid');
   }
   else
   {
     print("Form is invalid");

   }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset("assets/logo.png",height: 120,width: 160,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text("Login",style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurpleAccent,
                        fontFamily: 'Roboto'
                    ),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20.0),
                    child: Container(
                      child: TextFormField(
                        key: fromKey,
                        validator: (value)=>value.isEmpty?'Email can\'t be empty':null,
                        keyboardType: TextInputType.text,
                        controller: email,
                        autofocus: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            labelText: 'EMAIL '
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20.0),
                    child: Container(
                      child: TextFormField(
                        controller: pass,
                        autofocus: false,
                        validator: (value)=>value.isEmpty?'Password can\'t be empty':null,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'PASSWORD',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Text("Forgot Password?",style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 15.0,fontFamily: 'Roboto'
                          ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));
                          },
                        ),
                      ],
                    ),
                  ),
                 //SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 260),
                    child: Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(10.0),
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFefefef)
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUpPage(
                            )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("SignUp",style: TextStyle(fontFamily: "Roboto",fontSize: 17.0, color: Colors.deepPurpleAccent,
                              )),
                              // Spacer(),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Icon(Icons.arrow_forward_ios,size: 15.0, color: Colors.deepPurpleAccent,
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          height: 50,// specific value
                          child:  RaisedButton(
                              splashColor: Color(0xFF0bc1f3),
                              child: Text("Login",style: TextStyle(fontSize:20.0,fontFamily: 'Roboto')),
                              textColor: Color(0xFFffffff),
                              color: Colors.deepPurpleAccent,
                              onPressed: () async{
                                try {
                                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: email.text,
                                      password: pass.text
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                   // print('No user found for that email.');
                                    Toast.show("No user found for that email.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                  } else if (e.code == 'wrong-password') {
                                   // print('Wrong password provided for that user.');
                                    Toast.show("Wrong password provided for that user.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                  }
                                }
                                User user=FirebaseAuth.instance.currentUser;
                                if(!user.emailVerified)
                                  {
                                    addEmail();
                                    await user.sendEmailVerification();
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard(
                                    )));
                                  }
                               /*if(email.text.length==0||pass.text.length==0)
                                 {
                                   Toast.show("All Field Required..", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                 }else
                                   {
                                     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard(
                                     )));

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
                ],
              ),
            ],
          )
      ),
    );
  }
}
