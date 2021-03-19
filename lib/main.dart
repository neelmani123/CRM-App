//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/SplashScrren.dart';
import 'package:flutter/material.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/LoginPage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'Pages/SplashScrren.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple, primaryColor: Colors.deepPurple),
      home: SplashScrren(),
     // home: LoginPage(),
    );
  }
}
