import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fund_management/dashboardtiles1.dart';
import 'package:fund_management/deposit.dart';
import 'package:fund_management/login_screen.dart';
import 'package:fund_management/models/balanceModel.dart';
import 'package:fund_management/services/transactions.dart';
import 'package:fund_management/sideBar.dart';
import 'package:fund_management/visa_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fund_management/dashboardTiles.dart';
import 'package:back_pressed/back_pressed.dart';
import 'package:fund_management/services/databaseService.dart';

class Dashboard extends StatefulWidget{
Dashboard( this.email,{super.key});
final String email;  


@override
State<Dashboard> createState(){
return DepositState();
}


}
final DatabaseService database= DatabaseService.databaseservice;

class DepositState extends State<Dashboard>{
changeState(){
setState(() {
  print('state changed');
});
}
Future<int> getbalance()async{
List<Balancemodel> balance= await database.getBalanceDetails(widget.email);
for (Balancemodel index in balance){
  final int balance= index.balanceAmount;
  return balance;
  
}
return 5;
  }

@override
Widget build(context){

  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 248, 250, 213),
    drawer: Sidebar(widget.email),
    appBar:AppBar(
            elevation: 8,
            shadowColor: Colors.black,
        
            titleSpacing: 20,
              title: Text(
                'Dashboard ',
                style: GoogleFonts.ubuntu(
                    color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            flexibleSpace: Container(
              decoration:const BoxDecoration(gradient: LinearGradient(colors: [ Color.fromARGB(255, 5, 8, 212), Color.fromARGB(255, 68, 122, 239)],
              begin:Alignment.topLeft,
              end: Alignment.bottomRight)),
            ),
    ),
  body: OnBackPressed(
    
        perform: (){
          showDialog(context: context, builder:(context)=>  AlertDialog(title:const Text('Do you want to sign out'),
          content: Row(children: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }, child: const Text('Yes')),
            TextButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(widget.email)));
            }, child: const Text('No'))
          ],)
          ,alignment: Alignment.center));
        },
    child:
     
   
        Column(
          children: [
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection:Axis.horizontal,
              children: [
           SizedBox(
                height: 200,
                width: 380,
                child:Card(
                margin:  EdgeInsets.all(8),
                color: Color.fromARGB(255, 80, 34, 206),
                elevation: 5.0,
              
                shape: const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
                child: Center(
                  child:FutureBuilder(future: getbalance(), builder: (context,snapshot){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Current Balance',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                        Text(snapshot.data.toString()+" BDT",style: const TextStyle(fontSize: 30,color: Color.fromARGB(255, 240, 2, 2),fontWeight: FontWeight.bold),),
                       
                      ],
                    );
                  })
                ),
                )
              ),
                
              
              VisaCard(),
             ],
             ),
          ),
           const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(top:8 ),
              child: GridView.count(crossAxisCount: 3,childAspectRatio:(65/65) ,
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),   
                      children: [
                      
                        DashboardTiles('Deposit','assets/icons/deposit.png',widget.email,'deposit',changeState),
                        DashboardTiles('Summary','assets/icons/summary.png',widget.email,'summary',changeState),
                        DashboardTiles1('Transactions','assets/icons/transactions.png',widget.email,),
                        DashboardTiles('Transfer','assets/icons/transfer.png',widget.email,'transfer',changeState),
                        DashboardTiles('Withdraw','assets/icons/withdraw.png',widget.email,'withdraw',changeState)
                      
                      ],
                      
                      ),
            ),
          ],
        ),
     
  ),  
  );


}  

}

