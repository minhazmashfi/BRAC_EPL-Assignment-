import 'package:flutter/material.dart';
import 'package:fund_management/services/databaseService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fund_management/visa_card.dart';

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
   Future loading () async{
    
    showDialog(context: context, builder: (context){
                    return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 189, 28, 217),backgroundColor: Colors.amber,));});
    await Future.delayed( const Duration(seconds: 1));
    Navigator.of(context).pop();            

   }
  return  Scaffold(
    backgroundColor: Color.fromARGB(255, 227, 251, 231),
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
                color: Color.fromARGB(255, 55, 144, 95),
                elevation: 5.0,
              
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
                child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 4),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                   Row(
                      children: [const Text('Account Holder:',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 246, 243, 243),fontWeight: FontWeight.bold),),
                       Spacer(),
                      Text(widget.email,style: const TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      const SizedBox(width: 3)
                      ],
                    
                    ),
                    const SizedBox(height: 25,),    
                const    Row(
                      children: [Text('Available balance: ',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 237, 230, 230),fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text('50000 /-' ,style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 214, 237, 67),fontWeight: FontWeight.bold),),
                      SizedBox(width: 3)
                      ],
                    ),
                  const SizedBox(height: 25,),
               const    Row(
                      children: [Text('Recent Deposit',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 238, 234, 234),fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text('10000 /-',style: TextStyle(fontSize: 15,color:Color.fromARGB(255, 214, 237, 67),fontWeight: FontWeight.bold),),
                      SizedBox(width: 3)
                      ],
                    ),  
                  ],
                ),
              )
                )
              ),
                
              
              VisaCard(),
             ],
             ),
          ), 
      const SizedBox(height: 5,),     
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(255, 254, 247, 247)),
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
        showDialog(context: context, builder:(context)=>  AlertDialog(title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Do you want to proceed with the transaction?',style: TextStyle(fontSize: 14),),
            const SizedBox(height: 2,),
             Text('Amount: '+amountController.text+'/-',style: const TextStyle(fontSize: 14,))
          ],
        ),
          
          content: Row(children: [
            Spacer(),
            TextButton(onPressed: (){
               database.insertDeposit(widget.email, int.parse(amountController.text));
               Navigator.of(context).pop();
               loading();
            }, child: const Text('Confirm')),
            TextButton(onPressed: (){
           
            Navigator.of(context).pop();
            }, child: const Text('Cancel'))
          ],)
          ,alignment: Alignment.center));
          
          
          
          //prefs.setInt('balance', int.parse(amountController.text));
          // var prefs=await SharedPreferences.getInstance();
          // var balance =(prefs.getInt('balance'));
          // if (balance!=null){
          //   balance=balance + int.parse(amountController.text);
          //   prefs.setInt('balance', balance);
          // }
          // print(prefs.getInt('balance'));
          
        
        }, 
        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 6, 96, 13),shape:const  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
        child:const Text ('Deposit',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
    )  
    ],
  ),  
   );
  }

}