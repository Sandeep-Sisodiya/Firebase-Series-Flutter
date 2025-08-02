import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/forgotpassword.dart';
import 'package:firebase_series/phoneauth.dart';
import 'package:firebase_series/showdata.dart';
import 'package:firebase_series/signupPage.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async{
    if(email=="" && password==""){
      return UiHelper.CustomAlertBox(context, "Enter required Fields");
    }else{
      UserCredential? usercredential;
      try{
        usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Login')));
        });
      }
      on FirebaseException catch(ex){
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Login Page',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          UiHelper.CustomTextField(passwordController, "passward", Icons.password, true),
          SizedBox(height: 30,),
          UiHelper.CustomButton((){
            login(emailController.text.toString(), passwordController.text.toString());
          }, "Login"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an Account??',style: TextStyle(fontSize: 16),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Signuppage()));
              }, child: Text('Sign Up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))
            ],
          ),
          // SizedBox(height: 20,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Phoneauth()));
          }, child: Text("🔒Continue with Phone🔒", style: TextStyle(fontSize: 18),)),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgotpassword()));
          }, child: Text("Forgot Password", style: TextStyle(fontSize: 18),)),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Showdata()));
          }, child: Text("Any Updates", style: TextStyle(fontSize: 18),)),
        ],
      ),

    );
  }
}
