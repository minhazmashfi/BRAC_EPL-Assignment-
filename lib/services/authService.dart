import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_management/dashboard.dart';
import 'package:fund_management/models/balanceModel.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authservice {
  String message='';
  final DatabaseService database= DatabaseService.databaseservice;

  Future <void> signup ({
    required String email,
    required String password,
    required  BuildContext context
  }
  )async{
   try{
   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    Fluttertoast.showToast(msg: 'Sign up completed Successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: const Color.fromARGB(218, 82, 73, 73),
        textColor: const Color.fromARGB(255, 255, 253, 253),
        fontSize: 14.0,
  );
  database.insertBalance(email, 0);
  Future<List<Balancemodel>>balance=database.getBalanceDetails(email);
  print('balance');
   }
   on FirebaseException catch(e){
    Fluttertoast.showToast(msg: 'Duplicate/Incorrect mail not accepted',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: const Color.fromARGB(218, 82, 73, 73),
        textColor: const Color.fromARGB(255, 255, 253, 253),
        fontSize: 14.0,
  );

   }

  }
  
  Future <void> signin ({
    required String email,
    required String password,
    required BuildContext context
  }
  )async{
  try{  
   await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   await Future.delayed(Duration(seconds: 1));
   Fluttertoast.showToast(msg: 'Logged In Successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: const Color.fromARGB(218, 82, 73, 73),
        textColor: const Color.fromARGB(255, 255, 253, 253),
        fontSize: 14.0,
  );
   
   Navigator.push(context , MaterialPageRoute(builder: (context)=>Dashboard(email)));
  }
  on FirebaseAuthException catch(e){
    
   
  Fluttertoast.showToast(msg: 'Email/Password is incorrect',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: const Color.fromARGB(218, 82, 73, 73),
        textColor: const Color.fromARGB(255, 255, 253, 253),
        fontSize: 14.0,
  );
  Navigator.of(context).pop();
  }
  }
  

}