import 'package:flutter/material.dart';

class VisaCard extends StatelessWidget{

@override  
Widget build (context){
  return  SizedBox(
                height: 200,
                width: 380,
                child:Card(
                margin:  EdgeInsets.all(8),
                color: Color.fromARGB(255, 50, 3, 80),
                elevation: 5.0,
              
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
                child: Padding(
                  
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Spacer(),
                        Image.asset('assets/icons/m_c.png',height: 70,width: 40,
                        fit: BoxFit.contain,
          
                        colorBlendMode: BlendMode.srcIn,
                        ),

                        const SizedBox(width: 6,)
                      ],),
                    const   Text('Minhaz Uddin Ahmed',style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12,),
                    Text('4628 **** **** 4069',style: TextStyle(color: Color.fromARGB(255, 223, 226, 14), fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4,),
                   const Row(
                      children: [
                        Text('EXP/2028',style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Text('Visa',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(width: 6,)
                        
                      ],
                    ),
                    
                    
                    ],
                  ),
                ),
                )
              );
}

}