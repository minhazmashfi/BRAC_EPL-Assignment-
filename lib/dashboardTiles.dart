//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fund_management/deposit.dart';
import 'package:fund_management/services/transactions.dart';
import 'package:fund_management/summary.dart';
import 'package:fund_management/withdraw.dart';
import 'package:fund_management/trnansfer.dart';



class DashboardTiles extends StatelessWidget {
  DashboardTiles(this.labelText, this.iconString,this.email,this.operation,{super.key});
  final String labelText;
  final String iconString;
  final String email;
  String operation;
 
  @override
  Widget build(context) {
    return 
   
      
        Card(
            margin: const EdgeInsets.all(5),
            color:const Color.fromARGB(255, 248, 240, 127),
            elevation: 10.0,
            
            shape:const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
            shadowColor: Colors.black,
            child:InkWell(
              focusColor:const Color.fromARGB(255, 243, 201, 51) ,
              
              onTap: (){
             if (operation=='deposit'){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Deposit(email)));
             }
             else if (operation=='withdraw'){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Withdraw(email)));
             }
             else if (operation=='transfer'){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferPage(email)));
             }
             else if(operation=='summary'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SummaryPage(email))); 
             }
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