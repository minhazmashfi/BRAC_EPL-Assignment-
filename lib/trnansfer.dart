import 'package:flutter/material.dart';
import 'package:fund_management/deposit.dart';
import 'package:fund_management/models/balanceModel.dart';
import 'package:fund_management/models/transferdbModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fund_management/visa_card.dart';

class TransferPage extends StatefulWidget {
  TransferPage(this.email, this.changeState, {super.key});
  final String email;
  final Function changeState;

  @override
  State<TransferPage> createState() {
    return TransferPageState();
  }

  final DatabaseService database = DatabaseService.databaseservice;
}

class TransferPageState extends State<TransferPage> {
  final emailController = TextEditingController();
  final amountController = TextEditingController();
  changeTransState() {
    setState(() {
      print('state changed');
    });
  }

  Future<int> getbalance() async {
    List<Balancemodel> balance = await database.getBalanceDetails(widget.email);
    for (Balancemodel index in balance) {
      final int balance = index.balanceAmount;
      return balance;
    }
    return 5;
  }

  Future<int> getrecenttran() async {
    List<Transferdbmodel> transfers =
        await database.getTransferDetails(widget.email);
    int transfer = 0;
    for (Transferdbmodel index in transfers) {
      transfer = index.tranAmount;
    }
    return transfer;
  }

  @override
  Widget build(context) {
    Future loading() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 189, 28, 217),
              backgroundColor: Colors.amber,
            ));
          });
      await Future.delayed(const Duration(seconds: 1));
      changeTransState();
      Navigator.of(context).pop();
    }

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 251, 229, 221),
        appBar: AppBar(
          elevation: 8,
          shadowColor: Colors.black,
          titleSpacing: 20,
          title: Text(
            'Transfer',
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                        height: 200,
                        width: 380,
                        child: Card(
                            margin: EdgeInsets.all(8),
                            color: Color.fromARGB(255, 138, 68, 68),
                            elevation: 5.0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Account Holder:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 246, 243, 243),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.email,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 3)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  FutureBuilder(
                                      future: getbalance(),
                                      builder: (context, snapshot) {
                                        return Row(
                                          children: [
                                            const Text(
                                              'Available balance: ',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 237, 230, 230),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            Text(
                                              snapshot.data.toString() + " /-",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 214, 237, 67),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 3)
                                          ],
                                        );
                                      }),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  FutureBuilder(
                                      future: getrecenttran(),
                                      builder: (context, snapshot) {
                                        return Row(
                                          children: [
                                            const Text(
                                              'Recent Transfer',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 238, 234, 234),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            Text(
                                              snapshot.data.toString() + " /-",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 214, 237, 67),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 3)
                                          ],
                                        );
                                      })
                                ],
                              ),
                            ))),
                    VisaCard(),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.acme(
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.acme(
                          color: const Color.fromARGB(255, 68, 65, 65),
                          fontSize: 18),
                      hintText: 'Enter mail of reciever end',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 6, bottom: 10),
                child: Container(
                  decoration:const  BoxDecoration(color: Colors.white),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.acme(
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.acme(
                          color: const Color.fromARGB(255, 68, 65, 65),
                          fontSize: 18),
                      hintText: 'Enter amount',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Do you want to proceed with the transaction?',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      'Amount: ' + amountController.text + '/-',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ))
                                ],
                              ),
                              content: Row(
                                children: [
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        database.insertTransfer(
                                            widget.email,
                                            emailController.text,
                                            int.parse(amountController.text));
                                        database.updateBalance(
                                            widget.email,
                                            int.parse(amountController.text),
                                            'transfer',
                                            widget.changeState);
                                        Navigator.of(context).pop();
                                        loading();
                                      },
                                      child: const Text('Confirm')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'))
                                ],
                              ),
                              alignment: Alignment.center));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 66, 2, 53),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                    child: const Text(
                      'Transfer',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ));
  }
}
