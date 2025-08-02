import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/loginpage.dart';
import 'package:firebase_series/main.dart';
import 'package:flutter/material.dart';

class Checkuser extends StatefulWidget {
  const Checkuser({super.key});

  @override
  State<Checkuser> createState() => _CheckuserState();
}

class _CheckuserState extends State<Checkuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

  checkuser() {
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      return MyHomePage(title: "HomeScreen");
    }else{
      return LoginPage();
    }
  }

}
