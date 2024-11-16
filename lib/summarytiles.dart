import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Summarytiles extends StatelessWidget{
  Summarytiles(this.title,this.value,{super.key} );
  final String value;
  final String title;
@override
Widget build(Context){
  return SizedBox(
    height: 80,
    child:  Card(
      margin: EdgeInsets.only(left: 6,right: 6,top: 4),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
      color: const Color.fromARGB(71, 196, 197, 181),
      child: Row(
        children: [
         Image.asset('assets/icons/circle.png',width: 40,height: 35,) ,
         const SizedBox(width: 4,),
         Text(title,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 251, 251, 251)),),
         Spacer(),
         Text(value+'/- ',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 225, 216, 36)),),
         const SizedBox(width: 2,)

    
        ],
      )
    ),
  );

}

}