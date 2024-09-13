import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});
  @override
  State<ForgotPassPage> createState(){
    return ForgotPassPageState();
  }

}
class ForgotPassPageState extends State<ForgotPassPage>{
final emailController=TextEditingController();
Future passwordReset()async{
     try{
         await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
         
          }
          on FirebaseAuthException
          catch(e){
          print("hello"); 
          showDialog(context: context, builder: (context){
            return const AlertDialog(
              alignment: Alignment.bottomCenter,
              content: Text('Not a valid email')
              );
          }
          );

          } 
}




 @override
  Widget build(context){
    
  return Scaffold(
    backgroundColor:const Color.fromARGB(234, 255, 255, 255),
    appBar: AppBar(
     
      backgroundColor: const Color.fromARGB(255, 83, 109, 227),
    ),
    body:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Enter your email here to reset your password',style: TextStyle(fontSize: 16),),
        const SizedBox(height: 4,),
        Container(
          
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: TextFormField(
            controller: emailController,
          ),
        ),
      const SizedBox(height: 3,),  
      SizedBox(
        height: 40,
        width: 120,
        child: ElevatedButton(onPressed: (){
         passwordReset();
        }, 
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape:const RoundedRectangleBorder(borderRadius:BorderRadius.zero)),
        child:const Text('Submit',style: TextStyle(color: const Color.fromARGB(255, 255, 253, 253),fontSize: 14),)
        ))  


      ],
    ),

    
  );

  
  }

}
 
 