import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fund_management/services/authService.dart';
import 'package:fund_management/services/databaseService.dart';


class Signup extends StatelessWidget{
  final DatabaseService database= DatabaseService.databaseservice;
   Signup({super.key});
  @override
  Widget build(context ){
   final emailController=TextEditingController();
   final passwordController=TextEditingController();
    return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 83, 109, 227),
      title: Text('Signup Screen',style: GoogleFonts.acme(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
    ),
    backgroundColor: const Color.fromARGB(255, 249, 249, 249),
    body:Container(
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [ Color.fromARGB(255, 231, 225, 173),Color.fromARGB(255, 244, 247, 155),],
      begin:Alignment.bottomLeft,
      end: Alignment.topRight),),
      child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('BRAC ',
                            style: GoogleFonts.ubuntuMono(
                                color: const Color.fromARGB(255, 23, 23, 247),
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                                Text('EPL',
                            style: GoogleFonts.ubuntuMono(
                                color: const Color.fromARGB(255, 255, 38, 38),
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      ],
      
                    ),
                    const SizedBox(height: 3),
                  
                  Text('Sign up',
                        style: GoogleFonts.ubuntuMono(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                            textAlign:TextAlign.center,),
                    const SizedBox(height: 10),  
                  Container(
                     decoration: const BoxDecoration(color: const Color.fromARGB(255, 237, 233, 233),),
                    child: TextFormField(
                            controller:emailController ,
                            keyboardType: TextInputType.name,
                            style: GoogleFonts.acme(color: const Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              labelStyle:
                                GoogleFonts.acme(color:const Color.fromARGB(255, 68, 65, 65), fontSize: 18),
                              labelText: 'Email',
                              hintText: 'Enter Email',
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String user) {
                            
                            },
                          ),
                  ),
                        const SizedBox(height: 15),
                        Container(
                           decoration: const BoxDecoration(color: const Color.fromARGB(255, 237, 233, 233),),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.name,
                            style: GoogleFonts.acme(color: const Color.fromARGB(255, 8, 8, 8)),
                            decoration: InputDecoration(
                              focusColor: Colors.brown,
                              labelStyle:
                                GoogleFonts.acme(color:const Color.fromARGB(255, 68, 65, 65), fontSize: 18),
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (String pass) {
                              
                            },
                          ),
                        ),
                        const SizedBox(height: 20),  
                  ElevatedButton(onPressed: (){
                    database.insertBalance(emailController.text,0);
                    try{
                    Authservice().signup(email: emailController.text, password: passwordController.text);
                    }
                    catch(e){
                      showDialog(context: context, builder: (context){
            return const AlertDialog(
              alignment: Alignment.bottomCenter,
              content: Text('Duplicate Email/ Wrong format ')
              );
          }
          );
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))
                  ),
                  child:const Text('Sign up'))      
      
                  ]
      ),
         ),
    ),
   );

  }
}