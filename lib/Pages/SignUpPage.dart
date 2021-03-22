import 'package:crmapp/Firestore%20Database/signupdatabase.dart';
import 'package:flutter/material.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/LoginPage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';

import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name= new TextEditingController();
  TextEditingController mobile=new TextEditingController();
  TextEditingController email_id=new TextEditingController();
  TextEditingController password=new TextEditingController();
  UserCredential userCredential;
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: new Text(value,style: TextStyle(color: Colors.white,fontSize: 17),)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.deepPurpleAccent),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Center(
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 100,top: 30)),
                  Center(
                    child: Padding(padding: EdgeInsets.all(30),child:
                    Image.asset("assets/logo.png",width: 150,height: 70,),),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: Text("SIGN UP",style: TextStyle(
                  fontSize: 17,
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'
              ),),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20.0),
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0)
                      ),
                      labelText: 'Full Name'
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20.0),
              child: Container(
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: mobile,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0)
                      ),
                      labelText: 'Mobile Number'
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20.0),
              child: Container(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: email_id,
                  // inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[a-z A-Z ]")),],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0)
                      ),
                      labelText: 'Email Id'
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20.0),
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 50,// specific value
                    child:  RaisedButton(
                        splashColor: Color(0xFF0bc1f3),
                        child: Text("Sign Up",style: TextStyle(fontSize: 17.0,fontFamily: 'Roboto'),),
                        textColor: Color(0xFFffffff),
                        color: Colors.deepPurpleAccent,
                        onPressed: () async {
                          try
                          {
                            userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_id.text, password: password.text);
                           User user1=userCredential.user ;
                           await SignUpDatabase(uid: user1.uid).updateUserData(name.text, mobile.text, email_id.text);
                          } on FirebaseAuthException catch(e){
                            if(e.code=='weak-password')
                              {
                               // print('The password provided is too weak.');
                                //Toast.show("The password provided is too weak.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                showInSnackBar('The password provided is too weak...');
                              }
                            else if(e.code=='email-already-in-use')
                              {
                               // print('The account already exists for that email.');
                                //Toast.show("The account already exists for that email.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                showInSnackBar('The account already exists for that email...');
                              }
                          }
                          catch(e)
                          {
                            print(e);
                          }
                          if(userCredential!=null)
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
                            }
                          else
                            {
                              //Toast.show("Try Again..", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                              showInSnackBar('Try Again...');

                            }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            new BorderRadius.circular(
                                7.0))),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20.0)),
          ],
        ),
      ),
    );
  }
}
