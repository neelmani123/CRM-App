import 'dart:async';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/DashBoard.dart';
import 'package:flutter/material.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'DashBoard.dart';
import 'LoginPage.dart';

class SplashScrren extends StatefulWidget {
  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  void handleTimeout() {
   // AutoLogin.checkAutoLogin(context);
    main();
  }
  startTimeout() async {
    var duration = const Duration(seconds: 2);
    return new Timer(duration, handleTimeout);
  }
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image:DecorationImage(image:
                AssetImage("assets/logo.png",),
                  fit: BoxFit.contain,
                ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> main() async {
    if(FirebaseAuth.instance.currentUser!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
      print(FirebaseAuth.instance.currentUser);
    }
   else
     {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
     }
  }
}
