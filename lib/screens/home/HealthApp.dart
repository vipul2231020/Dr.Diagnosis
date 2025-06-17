import 'package:dr_diagnosis/common_files/AppRoute.dart';
import 'package:dr_diagnosis/screens/features/chatbot.dart';

import 'package:dr_diagnosis/screens/features/disease_predictor.dart';
import 'package:flutter/material.dart';

import 'bottomNavBar.dart';



class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double cardSize = screenSize.width * 0.38;
    final double spacing = screenSize.height * 0.02;
    int _selectedIndex = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(height: screenSize.height*.13,),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/logo.png'), // Replace with actual path
                        radius: 24,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Hi, Welcome Back',
                            style: TextStyle(color: Colors.blue, fontSize: 15,fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.notifications_none, color: Colors.blue,size: 32,),
                      SizedBox(width: 10),
                      Icon(Icons.settings, color: Colors.blue,size: 32,),
                    ],
                  ),
                ],
              ),
              //SizedBox(height: ),

              // Grid buttons
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: screenSize.width * 0.05,
                      runSpacing: spacing,
                      children: [
                        featureCard("Check\nSymptoms", Icons.health_and_safety, cardSize,(){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => predictor()));
                        }
                        ),
                        featureCard("Image\nDiagnosis", Icons.image_search, cardSize,(){}),
                        featureCard("Search\nMedicine", Icons.search, cardSize,(){Navigator.pushNamed(context,'/check_symptoms');}),
                        featureCard("Consult AI\nDoc Assistant", Icons.chat, cardSize,(){Navigator.push(context,MaterialPageRoute(builder: (context) => chatbot()));}),
                        featureCard("Health\nHistory", Icons.history, cardSize,(){Navigator.pushNamed(context,'/check_symptoms');}),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget featureCard(String title, IconData icon, double size,VoidCallback onTap) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: size * 0.3, color: Colors.blue[700]),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}