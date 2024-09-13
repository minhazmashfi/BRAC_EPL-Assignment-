import 'package:flutter/material.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deposit extends StatefulWidget{
const Deposit(this.email,{super.key});
final String email;
@override
State<Deposit> createState() {
 return DepositState();
}
}
final DatabaseService database= DatabaseService.databaseservice;

class DepositState extends State<Deposit>{

@override
  Widget build(BuildContext context) {
  final amountController=TextEditingController();
  return  Scaffold(
    backgroundColor: Color.fromARGB(255, 251, 221, 210),
    appBar:AppBar(
            elevation: 8,
            shadowColor: Colors.black,
        
            titleSpacing: 20,
              title: Text(
                'Deposit',
                style: GoogleFonts.ubuntu(
                    color: const Color.fromARGB(255, 255, 255, 255), fontSize: 24, fontWeight: FontWeight.bold),
              ),
            flexibleSpace: Container(
              decoration:const BoxDecoration(gradient: LinearGradient(colors: [ Color.fromARGB(255, 5, 8, 212), Color.fromARGB(255, 68, 122, 239)],
              begin:Alignment.topLeft,
              end: Alignment.bottomRight)),
            ),
    ),
  body: Column(
    children: [
     Container(
      height: 180,
      width: double.infinity,
       child:   Card(
              
              margin: EdgeInsets.all(6),
              color:Color.fromARGB(255, 252, 203, 181),
              elevation: 8,
              
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                   Row(
                      children: [Text('Account Holder:',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text(widget.email,style: TextStyle(fontSize: 14,color: Colors.black),),
                      SizedBox(width: 3)
                      ],
                    
                    ),
                    const SizedBox(height: 25,),    
                  const  Row(
                      children: [Text('Available balance:',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text('50000 BDT',style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 247, 22, 22)),),
                      SizedBox(width: 3)
                      ],
                    ),
                  const SizedBox(height: 25,),
                const   Row(
                      children: [Text('Recent Transaction',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text('N/A',style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 242, 12, 12)),),
                      SizedBox(width: 3)
                      ],
                    ),  
                  ],
                ),
              )
          ),
     ),  
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.name,
                                style: GoogleFonts.acme(color: const Color.fromARGB(255, 0, 0, 0)),
                                decoration: InputDecoration(
                                  labelStyle:
                                  GoogleFonts.acme(color:const Color.fromARGB(255, 68, 65, 65), fontSize: 18),
                                  
                                  hintText: 'Enter Amount',
                                  border: const OutlineInputBorder(),
                                ),
          ),
        ),
      ),
    const SizedBox(height: 2,),
    SizedBox(
      height: 60,
      width: 200,
      child: SizedBox(
         height: 60,
         width: 250,
        child: ElevatedButton(onPressed: ()async{
        
          
          database.insertDeposit(widget.email, int.parse(amountController.text));
          
          //prefs.setInt('balance', int.parse(amountController.text));
          var prefs=await SharedPreferences.getInstance();
          var balance =(prefs.getInt('balance'));
          if (balance!=null){
            balance=balance + int.parse(amountController.text);
            prefs.setInt('balance', balance);
          }
          print(prefs.getInt('balance'));
          
        
        }, 
        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 23, 230, 40),shape:const  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
        child:const Text ('Deposit',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    )  
    ],
  ),  
   );
  }

}