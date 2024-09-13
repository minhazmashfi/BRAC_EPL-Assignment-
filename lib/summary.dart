import 'package:flutter/material.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryPage extends StatefulWidget{
SummaryPage(this.email,{super.key});
final String email;

@override
State<SummaryPage> createState() {
 return SummaryPageState();
}

} 

class SummaryPageState extends State<SummaryPage>{
var balance=0;
@override
  void initState() {
    
    super.initState();
    balancedetails();
  }  
@override

  Widget build(BuildContext context) {
  
  return  Scaffold(
    backgroundColor: Color.fromARGB(255, 225, 218, 216),
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
  body: Card(
              
              margin: EdgeInsets.all(6),
              color:Color.fromARGB(255, 253, 251, 250),
              elevation: 12,
              
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                   Row(
                      children: [const Text('Account Holder:',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text(widget.email,style:const  TextStyle(fontSize: 14,color: Colors.black),),
                      const SizedBox(width: 3)
                      ],
                    
                    ),
                    const SizedBox(height: 25,),    
                  Row(
                      children: [Text('Available balance:',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text(balance.toString()+'BDT',style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 247, 22, 22)),),
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

  );
  }
   balancedetails() async{
  var prefs= await SharedPreferences.getInstance();
  var balancepref=prefs.getInt("balance");
  if (balancepref!=null){
    balance=balancepref;
  }
} 

}  
