import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fund_management/dashboard.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Authservice {
  String message='';
  Future <void> signup ({
    required String email,
    required String password
  }
  )async{
   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

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
  }
  }
  

}