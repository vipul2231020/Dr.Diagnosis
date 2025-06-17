import 'dart:async';

import 'package:dr_diagnosis/main.dart';
import 'package:dr_diagnosis/common_files/colors.dart';
import 'package:dr_diagnosis/common_files/screen_size.dart';
//import 'package:dr_diagnosis/screens/login/login_dummy.dart';
import 'package:dr_diagnosis/screens/login/login_page.dart';
import 'package:dr_diagnosis/screens/signup/signup_screen.dart';
import 'package:dr_diagnosis/screens/wlcome/widgets_1.dart';
import 'package:flutter/material.dart';

import '../home/HealthApp.dart';
class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: height*.15)),
                Image.asset('assets/logo.png'),
                SizedBox(height: height*.009,),
                Text("Welcome!",style: TextStyle(fontSize: height*.07,color: AppTheme.dark),),
                SizedBox(height: height*.05,),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add login action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.dark, // Deep blue
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  ),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  }, child: Text(
                    ' Log In ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height*.025,
                    ),
                  ),)
            
            
                ),
                SizedBox(height: height*.01,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightBlue, // Light blue
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  ),
                  child: TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppTheme.dark,
                          fontSize: height*.025,
                        ),
                      ),)
            
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
