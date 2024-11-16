//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fund_management/deposit.dart';
import 'package:fund_management/services/transactions.dart';



class DashboardTiles1 extends StatelessWidget {
  DashboardTiles1(this.labelText, this.iconString,this.email,{super.key});
  final String labelText;
  final String iconString;
  final String email;
 
  @override
  Widget build(context) {
    return 
    Card(
        margin: const EdgeInsets.all(5),
        color:const  Color.fromARGB(255, 248, 240, 127),
        elevation: 10.0,
        
        shape:const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
        shadowColor: Colors.black,
        child:InkWell(
          focusColor:const Color.fromARGB(255, 243, 201, 51) ,
          
          onTap: (){
         
         Navigator.push(context, MaterialPageRoute(builder: (context)=>Transactions(email)));
      },
          child:  Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            Image.asset(iconString,height:70,width:70),
            Text(labelText,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black,),textAlign: TextAlign.center,)
           
           ]
           ),
        ),
          
      );
      
      
  
  }
}