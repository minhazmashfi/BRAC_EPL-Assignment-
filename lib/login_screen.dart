import 'package:flutter/material.dart';
import 'package:fund_management/forgotpasspage.dart';
import 'package:fund_management/services/authService.dart';
import 'package:fund_management/signUp.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() {
    return Login_Screen_State();
  }

}
 
class Login_Screen_State extends State<LoginScreen>{
  @override
  Widget build(context){
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
 
   return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 83, 109, 227),
      title: Text('Login Screen',style: GoogleFonts.acme(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
    ),
    backgroundColor: const Color.fromARGB(255, 249, 249, 249),
    body:Container(
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [ Color.fromARGB(255, 180, 247, 239),Color.fromARGB(255, 34, 229, 206),],
      begin:Alignment.bottomLeft,
      end: Alignment.topRight)),
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
                  
                  Text('Login',
                        style: GoogleFonts.ubuntuMono(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                            textAlign:TextAlign.center,),
                    const SizedBox(height: 10),  
                  Container(
                    decoration: const BoxDecoration(color: const Color.fromARGB(255, 237, 233, 233),),
                    
                    child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.name,
                            style: GoogleFonts.acme(color: const Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              labelStyle:
                                GoogleFonts.acme(color:const Color.fromARGB(255, 68, 65, 65), fontSize: 18),
                              labelText: 'Email',
                              hintText: 'Enter Email',
                              border: const OutlineInputBorder(),
                            ),
                           
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
                           
                          ),
                        ),
                        const SizedBox(height: 20),  
                  ElevatedButton(onPressed: (){
                   showDialog(context: context, builder: (context){
                    return const Center(child: CircularProgressIndicator(color: Colors.amber,));});
                   Authservice().signin(email: emailController.text, password: passwordController.text, context: context);
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))
                  ),
                  child:const Text('Login')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Create Account?',style: TextStyle(color: const Color.fromARGB(255, 75, 66, 66),fontSize: 12),),
                     
                      TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup())), child:const Text('Sign up',style:TextStyle(color:Color.fromARGB(255, 239, 42, 154),fontSize: 14)))
                    ],
                  ),
                  
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassPage()));
                  }, child:const Text('Forgot password?',style:TextStyle(color: Color.fromARGB(255, 21, 28, 235),fontSize: 12)))
                        
      
                  ]
      ),
         ),
    ),
   );
  }
}