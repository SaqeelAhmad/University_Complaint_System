import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'user_login/login.dart';
import 'users/screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
     if(user != null){
      
      Timer(
        const Duration(seconds: 6),   //splash screen timing----------------------------------------------------------
    (){
       setState(() {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
           
           return  Screen1();
         }));
       });   
    }
      );
    }else{
      Timer(
        const Duration(seconds: 6),
          (){
          setState(() {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MyLogin()));

          });
          }
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 height: 100,
                 width: double.infinity,

                 child: DefaultTextStyle(
                   style: const TextStyle(
                     fontSize: 30.0,
                     fontFamily: 'Bobbers',
                   ),
                   child: Center(
                     child: AnimatedTextKit(
                       animatedTexts: [

                         // splash screen--------------------------------------------------------------------------
                         TyperAnimatedText('UNIVERSITY', textStyle: TextStyle(color: Colors.greenAccent)),
                         TyperAnimatedText('COMPLAINT', textStyle: TextStyle(color: Colors.greenAccent)),
                         TyperAnimatedText('MANAGEMENT', textStyle: TextStyle(color: Colors.greenAccent)),
                         TyperAnimatedText('SYSTEM', textStyle: TextStyle(color: Colors.greenAccent)),
                       ],
                       onTap: () {
                         print("Tap Event");
                       },
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 80,),
               SpinKitRipple(color: Colors.greenAccent,size: 100,), // text color__________________________________________________________
             ],
           ),
        );


  }
}
