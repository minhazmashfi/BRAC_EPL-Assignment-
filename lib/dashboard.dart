import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fund_management/dashboardtiles1.dart';
import 'package:fund_management/deposit.dart';
import 'package:fund_management/login_screen.dart';
import 'package:fund_management/services/transactions.dart';
import 'package:fund_management/sideBar.dart';
import 'package:fund_management/visa_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fund_management/dashboardTiles.dart';
import 'package:back_pressed/back_pressed.dart';

class Dashboard extends StatelessWidget{
const Dashboard( this.email,{super.key});
final String email;  
@override
Widget build(context){
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 248, 250, 213),
    drawer: Sidebar(email),
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
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(email)));
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
            const  SizedBox(
                height: 200,
                width: 380,
                child:Card(
                margin:  EdgeInsets.all(8),
                color: Color.fromARGB(255, 80, 34, 206),
                elevation: 5.0,
              
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                   children: [
                    Text('Current Balance:',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    Text('50000 BDT',style: TextStyle(color: Color.fromARGB(255, 228, 244, 14), fontSize: 28, fontWeight: FontWeight.bold),)
                   ],
                  
                  ),
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
                      
                        DashboardTiles('Deposit','assets/icons/deposit.png',email,'deposit'),
                        DashboardTiles('Summary','assets/icons/summary.png',email,'summary'),
                        DashboardTiles1('Transactions','assets/icons/transactions.png',email,),
                        DashboardTiles('Transfer','assets/icons/transfer.png',email,'transfer'),
                        DashboardTiles('Withdraw','assets/icons/withdraw.png',email,'withdraw')
                      
                      ],
                      
                      ),
            ),
          ],
        ),
     
  ),  
  );
}  
}