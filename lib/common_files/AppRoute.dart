
import 'package:dr_diagnosis/screens/features/disease_predictor.dart';
import 'package:dr_diagnosis/screens/features/disease_predictor.dart';
import 'package:dr_diagnosis/screens/home/HealthApp.dart';
import 'package:flutter/material.dart';

import '../screens/features/disease_predictor.dart';
import '../screens/features/disease_predictor.dart';



class AppRoutes {
  //static const String home = '/';
  //static const String checkSymptoms = '/sending_symptoms';
  static const String homePage = '/home_screen';
  static const String predict = '/disease_predictor';

  // static const String imageDiagnosis = '/image_diagnosis';
  // static const String searchMedicine = '/search_medicine';
  // static const String consultDoctor = '/consult_doctor';
  // static const String healthHistory = '/health_history';

  static Map<String, WidgetBuilder> routes = {
  //  home: (context) => const HomePage(),
    predict:(context) =>const predictor(),
    homePage: (context) => const HealthApp(),
   // imageDiagnosis: (context) => const symptoms(),
    // searchMedicine: (context) => const symptoms(),
    // consultDoctor: (context) => const symptoms(),
    // healthHistory: (context) => const symptoms(),
  };
}
