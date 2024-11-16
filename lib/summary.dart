import 'package:flutter/material.dart';
import 'package:fund_management/deposit.dart';
import 'package:fund_management/models/withdrawdbModel.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:fund_management/summarytiles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryPage extends StatefulWidget{
SummaryPage(this.email,{super.key});
final String email;
final database=DatabaseService.databaseservice.getDatabase();
@override
State<SummaryPage> createState() {
 return SummaryPageState();
}

} 

class SummaryPageState extends State<SummaryPage>{
var balance=0;

@override

  Widget build(BuildContext context) {
  
  return  Scaffold(
    backgroundColor: Color.fromARGB(255, 40, 39, 39),
    appBar:AppBar(
            elevation: 8,
            shadowColor: Colors.black,
        
            titleSpacing: 20,
              title: Text(
                'Summary',
                style: GoogleFonts.ubuntu(
                    color: const Color.fromARGB(255, 255, 255, 255), fontSize: 24, fontWeight: FontWeight.bold),
              ),
            flexibleSpace: Container(
              decoration:const BoxDecoration(gradient: LinearGradient(colors: [ Color.fromARGB(255, 5, 8, 212), Color.fromARGB(255, 68, 122, 239)],
              begin:Alignment.topLeft,
              end: Alignment.bottomRight)),
            ),
    ),
  body:Padding(
    padding: const EdgeInsets.only(top: 4),
    child: ListView(
      children: [
        
        Summarytiles('Total Deposit', '100000'),
        Summarytiles('Total Withdrawal', '30000'),
        Summarytiles('Total Transfer', '40000'),
        Summarytiles('Recent Deposit', '5000'),
        Summarytiles('Recent Withdrawal', '18000'),
        Summarytiles('Recent Transfer', '12000'),
      ],
    ),
  )

  );
  }

}
