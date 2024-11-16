import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fund_management/accountInfo.dart';
import 'package:fund_management/login_screen.dart';


class Sidebar extends StatelessWidget{
  const Sidebar(this.email,{super.key});
  final String email;

  @override 
  Widget build(context){
    return Drawer(
      width: 250,
      backgroundColor:const  Color.fromARGB(255, 215, 215, 235),
      child: ListView(
        children:  [
          UserAccountsDrawerHeader(accountName:Text('User Name'), accountEmail:Text(email)
          ,
          decoration: const BoxDecoration(
            color:Color.fromARGB(255, 24, 28, 212)
          ),
        
          currentAccountPicture:CircleAvatar(
            child: ClipOval(child: Image.asset('assets/icons/avatar.png',fit: BoxFit.cover,))
            ,
          ) 
          ),
        ListTile(
            title: const Text('Account Information'),
            leading: const Icon(Icons.account_box_rounded),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Accountinfo(email)));
            },
            
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout_rounded),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            },
          )
          
        ],
      ),
    );

  }
}