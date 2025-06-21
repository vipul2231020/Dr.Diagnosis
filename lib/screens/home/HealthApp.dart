import 'package:dr_diagnosis/common_files/AppRoute.dart';
import 'package:dr_diagnosis/screens/features/chatbot.dart';

import 'package:dr_diagnosis/screens/features/disease_predictor.dart';
import 'package:dr_diagnosis/screens/home/ProfilePage.dart';
import 'package:flutter/material.dart';

import '../../common_files/Common_Data.dart';
import '../../common_files/NavigatorInstagram.dart';
import 'bottomNavBar.dart';
import 'package:dr_diagnosis/common_files/network_url.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  Map<String, dynamic>? userData;
  String name = "Guest";
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final token = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse(networkUrl.Profile),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
        name = userData?['fullName'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("Failed to load profile: ${response.body}");
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double cardSize = screenSize.width * 0.38;
    final double spacing = screenSize.height * 0.02;

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
                      SizedBox(height: screenSize.height * .13),
                      GestureDetector(
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('assets/logo.png'),
                          radius: 24,
                        ),
                        onTap: () {
                          Navigator.of(context).push(createInstagramRoute(ProfileScreen()));
                        },
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi, Welcome Back',
                            style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            name.isNotEmpty ? name : 'Guest',
                            style: const TextStyle(
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
                      Icon(Icons.notifications_none, color: Colors.blue, size: 32),
                      SizedBox(width: 10),
                      Icon(Icons.settings, color: Colors.blue, size: 32),
                    ],
                  ),
                ],
              ),

              // Grid buttons
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: screenSize.width * 0.05,
                      runSpacing: spacing,
                      children: [
                        featureCard("Check\nSymptoms", Icons.health_and_safety, cardSize, () {
                          Navigator.of(context).push(createInstagramRoute(predictor()));
                        }),
                        featureCard("Image\nDiagnosis", Icons.image_search, cardSize, () {}),
                        featureCard("Search\nMedicine", Icons.search, cardSize, () {}),
                        featureCard("Consult AI\nDoc Assistant", Icons.chat, cardSize, () {
                          Navigator.of(context).push(createInstagramRoute(chatbot()));
                        }),
                        featureCard("Health\nHistory", Icons.history, cardSize, () {}),
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

  Widget featureCard(String title, IconData icon, double size, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
