import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Accountinfo extends StatelessWidget{
  Accountinfo(this.email,{super.key});
  final String email;

@override
  Widget build(BuildContext context) {
    
  return Scaffold(
    backgroundColor:  Color.fromARGB(255, 233, 230, 230),
    appBar:AppBar(
            elevation: 8,
            shadowColor: Colors.black,
        
            titleSpacing: 20,
              title: Text(
                'Account Information',
                style: GoogleFonts.ubuntu(
                    color: const Color.fromARGB(255, 255, 255, 255), fontSize: 24, fontWeight: FontWeight.bold),
              ),
            flexibleSpace: Container(
              decoration:const BoxDecoration(gradient: LinearGradient(colors: [ Color.fromARGB(255, 5, 8, 212), Color.fromARGB(255, 68, 122, 239)],
              begin:Alignment.topLeft,
              end: Alignment.bottomRight)),
            ),
    ),
  body:const Padding(
    padding: const EdgeInsets.only(top: 80),
    child: SizedBox(
      height: 500,
      child: const Card(
        margin: EdgeInsets.only(left: 12,right: 12,top: 10),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 20,left: 6,right: 6),
          child: Column(
            children: [
            Row(
              children: [
                Text('Account Holder: ',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold), ),
                Spacer(),
                Text('Minhaz Uddin Ahmed',style: TextStyle(color: Color.fromARGB(255, 160, 85, 31),fontSize: 15,fontWeight: FontWeight.bold), ),
                
              ],
            ),
            const SizedBox(height: 40,),
             Row(
              children: [
                Text('Address: ',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold), ),
                Spacer(),
                Text('93,Chatteshary road, Excel building',style: TextStyle(color: Color.fromARGB(255, 160, 85, 31),fontSize: 15,fontWeight: FontWeight.bold), ),
                
              ],
            ),
            const SizedBox(height: 40,),
             Row(
              children: [
                Text('Card Number:',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold), ),
                Spacer(),
                Text('4062 **** **** 4069',style: TextStyle(color: Color.fromARGB(255, 160, 85, 31),fontSize: 15,fontWeight: FontWeight.bold), ),
                
              ],
            ),
            const SizedBox(height: 40,),
             Row(
              children: [
                Text('Phone No:  ',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold), ),
                Spacer(),
                Text('+880186****846',style: TextStyle(color: Color.fromARGB(255, 160, 85, 31),fontSize: 15,fontWeight: FontWeight.bold), ),
                
              ],
            ),
            const SizedBox(height: 40,),
             Row(
              children: [
                Text('Birth Date:',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold), ),
                Spacer(),
                Text('25 October,1998',style: TextStyle(color: Color.fromARGB(255, 160, 85, 31),fontSize: 15,fontWeight: FontWeight.bold), ),
                
              ],
            ),
            const SizedBox(height: 40,),
               Row(
              children: [
                Text('Branch Details:',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold), ),
                Spacer(),
                Text('Mohakhali, Dhaka',style: TextStyle(color: Color.fromARGB(255, 160, 85, 31),fontSize: 15,fontWeight: FontWeight.bold), ),
                
              ],
            ),
            
            ],
          ),
        ),
      ),
    ),
  )

  );
  }
}