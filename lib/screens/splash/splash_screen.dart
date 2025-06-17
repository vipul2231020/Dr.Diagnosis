import 'dart:async';

import 'package:dr_diagnosis/main.dart';
import 'package:dr_diagnosis/common_files/colors.dart';
import 'package:dr_diagnosis/common_files/screen_size.dart';
import 'package:dr_diagnosis/screens/wlcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../home/HealthApp.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => welcome())));



    return SingleChildScrollView(
      child: MaterialApp(
        home: Scaffold(
          /* appBar: AppBar(
            title: Text("MyApp"),
            backgroundColor:
                Colors.blue, //<- background color to combine with the picture :-)
          ),*/
          body: Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: height*.15)),
                Image.asset('assets/logo.png'),
                SizedBox(height: height*.08,),
                Text("Dr. Diagnosis",style: TextStyle(fontSize: height*.07,color: AppTheme.dark),),
      
      
            ],
            ),
          ),
        ),
      ),
    );
  }
}
