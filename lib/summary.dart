import 'package:flutter/material.dart';
import 'package:fund_management/deposit.dart';
import 'package:fund_management/models/depositdbModel.dart';
import 'package:fund_management/models/transferdbModel.dart';
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
  Future<int> getrecenttran() async {
    List<Transferdbmodel> transfers =
        await database.getTransferDetails(widget.email);
    int transfer = 0;
    for (Transferdbmodel index in transfers) {
      transfer = index.tranAmount;
    }
    return transfer;
  }
 Future<int> getrecentdep() async {
    List<Depositdbmodel> deposits = await database.getDepDetails(widget.email);
    int deposit = 0;
    for (Depositdbmodel index in deposits) {
      deposit = index.depAmount;
    }
    return deposit;
  } 

 Future<int> getAlltran() async {
    List<Transferdbmodel> transfers =
        await database.getTransferDetails(widget.email);
    int transfer = 0;
    for (Transferdbmodel index in transfers) {
      transfer = transfer+index.tranAmount;
    }
    return transfer;
  }

 Future<int> getAlldep() async {
    List<Depositdbmodel> deposits = await database.getDepDetails(widget.email);
    int deposit = 0;
    for (Depositdbmodel index in deposits) {
      deposit = deposit+index.depAmount;
    }
    return deposit;
  }
 Future<int> getrecentWith() async {
    List<Withdrawdbmodel> withdrawals =
        await database.getWithdrawDetails(widget.email);
    int withdrawal = 0;
    for (Withdrawdbmodel index in withdrawals) {
      withdrawal = index.withdrawAmount;
    }
    return withdrawal;
  }  
 Future<int> getAllWith() async {
    List<Withdrawdbmodel> withdrawals =
        await database.getWithdrawDetails(widget.email);
    int withdrawal = 0;
    for (Withdrawdbmodel index in withdrawals) {
      withdrawal = withdrawal+ index.withdrawAmount;
    }
    return withdrawal;
  }  


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
        
     FutureBuilder(
                                      future: getAlldep(),
                                      builder: (context, snapshot) {
                                        return    Summarytiles('Total Deposit', snapshot.data.toString());}),
        FutureBuilder(
                                      future: getAllWith(),
                                      builder: (context, snapshot) {
                                        return     Summarytiles('Total Withdrawal', snapshot.data.toString());}),
        FutureBuilder(
                                      future: getAlltran(),
                                      builder: (context, snapshot) {
                                        return Summarytiles('Total Transfer',snapshot.data.toString());}),
      FutureBuilder(
                                      future: getrecentdep(),
                                      builder: (context, snapshot) {
                                        return   Summarytiles('Recent Deposit', snapshot.data.toString());}),
      FutureBuilder(
                                      future: getrecentWith(),
                                      builder: (context, snapshot) {
                                        return   Summarytiles('Recent Withdrawal',snapshot.data.toString());}),
       FutureBuilder(
                                      future: getrecenttran(),
                                      builder: (context, snapshot) {
                                        return  Summarytiles('Recent Transfer', snapshot.data.toString());})
      ],
    ),
  )

  );
  }

}
