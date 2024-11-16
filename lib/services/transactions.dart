import 'package:flutter/material.dart';
import 'package:fund_management/models/depositdbModel.dart';
import 'package:fund_management/models/transferdbModel.dart';
import 'package:fund_management/models/withdrawdbModel.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:google_fonts/google_fonts.dart';

class Transactions extends StatefulWidget {
  Transactions(this.useremail,{super.key});
  final String useremail;
  @override
  State<Transactions> createState() {
    return TransactionsState();
  }
}

final DatabaseService database = DatabaseService.databaseservice;

class TransactionsState extends State<Transactions> {
  @override
  Widget build(context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 243, 218),
        appBar: AppBar(
          elevation: 8,
          shadowColor: Colors.black,
          titleSpacing: 20,
          title: Text(
            'Transactions',
            style: GoogleFonts.ubuntu(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 5, 8, 212),
              Color.fromARGB(255, 68, 122, 239)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          bottom:TabBar(
                indicatorColor: const Color.fromARGB(255, 247, 244, 244),
                indicatorWeight: 4,
                labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),
                unselectedLabelStyle:const  TextStyle(color: Color.fromARGB(255, 243, 241, 241),fontWeight: FontWeight.bold),
                tabs: [
                Tab(text:'Deposits',icon: Image.asset('assets/icons/deposit_icon.png',height: 30,width: 30)),
                Tab(text: 'Withdrawals',icon: Image.asset('assets/icons/withdraw_icon.png',height: 30,width: 30)),
                Tab(text: 'Transfers',icon: Image.asset('assets/icons/transfer_icon.png',height: 30,width: 30)),
                
              ]),
              ),
        
        
        body: TabBarView(children: 
        [
          depList(widget.useremail),
          withdrawList(widget.useremail),
          transferList(widget.useremail)
        ]),
      ),
    );
  }

  Widget depList(useremail) {
    return FutureBuilder(
        future: database.getDepDetails(useremail),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Depositdbmodel deposits = snapshot.data![index];
                return Container(
                  height: 60,
                  width: double.infinity,
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(5),
                    color: const Color.fromARGB(255, 249, 226, 157),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       const Text('Deposit',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 16, 230, 16),
                                fontWeight: FontWeight.bold)),
                        Text(deposits.accName,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(deposits.depAmount.toString()+' BDT',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 44, 168, 6),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              });
        });
  }
Widget withdrawList(useremail) {
  
    return FutureBuilder(
        future: database.getWithdrawDetails(useremail),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Withdrawdbmodel deposits = snapshot.data![index];
                return Container(
                  height: 60,
                  width: double.infinity,
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(5),
                    color: const Color.fromARGB(255, 249, 226, 157),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       const Text('Withdraw',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 244, 51, 30),
                                fontWeight: FontWeight.bold)),
                        Text(deposits.accName,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(deposits.withdrawAmount.toString()+" BDT",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 153, 34, 34),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              });
        });
  }
Widget transferList(useremail) {
    return FutureBuilder(
        future: database.getTransferDetails(useremail),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Transferdbmodel transfers = snapshot.data![index];
                return Container(
                  height: 60,
                  width: double.infinity,
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(5),
                    color: const Color.fromARGB(255, 249, 226, 157),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(transfers.accName,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)),
                        Text(transfers.recName,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 9, 13, 106),
                                fontWeight: FontWeight.bold)),
                        Text(transfers.tranAmount.toString()+" BDT",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 153, 34, 34),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              });
        });
  }  

}
