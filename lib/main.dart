import 'package:flutter/material.dart';
import 'package:fund_management/balancePreference.dart';
import 'package:fund_management/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

//Balancepreference.init();
  runApp(const MaterialApp(home: LoginScreen(),debugShowCheckedModeBanner: false,));
}
