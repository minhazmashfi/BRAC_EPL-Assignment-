import 'package:flutter/material.dart';
import 'package:fund_management/models/balanceModel.dart';
import 'package:fund_management/models/depositdbModel.dart';
import 'package:fund_management/models/withdrawdbModel.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fund_management/visa_card.dart';

class Withdraw extends StatefulWidget {
  const Withdraw(this.email, this.changeState, {super.key});
  final String email;
  final Function changeState;
  @override
  State<Withdraw> createState() {
    return DepositState();
  }
}

final DatabaseService database = DatabaseService.databaseservice;

class DepositState extends State<Withdraw> {
  changeWithdState() {
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

  Future<int> getrecentdep() async {
    List<Withdrawdbmodel> withdrawals =
        await database.getWithdrawDetails(widget.email);
    int withdrawal = 0;
    for (Withdrawdbmodel index in withdrawals) {
      withdrawal = index.withdrawAmount;
    }
    return withdrawal;
  }

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
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
      changeWithdState();
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 223, 223),
      appBar: AppBar(
        elevation: 8,
        shadowColor: Colors.black,
        titleSpacing: 20,
        title: Text(
          'Withdraw',
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
      body: Column(
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
                        color: Color.fromARGB(255, 189, 138, 76),
                        elevation: 5.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Account Holder:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 246, 243, 243),
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
                                  future: getrecentdep(),
                                  builder: (context, snapshot) {
                                    return Row(
                                      children: [
                                        const Text(
                                          'Recent Withdrawal',
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
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration:const  BoxDecoration(color: Colors.white),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.name,
                style:
                    GoogleFonts.acme(color: const Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.acme(
                      color: const Color.fromARGB(255, 68, 65, 65),
                      fontSize: 18),
                  hintText: 'Enter Amount',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 2,
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
                              Text('Amount: ' + amountController.text + '/-',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ))
                            ],
                          ),
                          content: Row(
                            children: [
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    database.insertWithdrawal(widget.email,
                                        int.parse(amountController.text));
                                    database.updateBalance(
                                        widget.email,
                                        int.parse(amountController.text),
                                        'withdraw',
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
                    backgroundColor: const Color.fromARGB(255, 181, 10, 10),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero))),
                child: const Text(
                  'Withdraw',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
