import 'package:dr_diagnosis/common_files/AppRoute.dart';
import 'package:dr_diagnosis/screens/features/chatbot.dart';


import 'package:dr_diagnosis/screens/home/HealthApp.dart';
import 'package:dr_diagnosis/screens/home/Home_page.dart';
import 'package:dr_diagnosis/screens/home/ProfilePage.dart';
import 'package:dr_diagnosis/screens/login/login_page.dart';
import 'package:dr_diagnosis/screens/otp/OtpVerificationScreen.dart';
import 'package:dr_diagnosis/screens/signup/signup_screen.dart';
import 'package:dr_diagnosis/screens/splash/splash_screen.dart';
import 'package:dr_diagnosis/screens/wlcome/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Splash(),debugShowCheckedModeBanner: false,
  routes: AppRoutes.routes,)
  );
}

