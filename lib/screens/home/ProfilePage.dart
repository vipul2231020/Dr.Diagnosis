import 'package:dr_diagnosis/common_files/network_url.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common_files/Common_Data.dart';



class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = const FlutterSecureStorage();
  Map<String, dynamic>? userData;
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
        SharedData.name = userData?['fullName'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print("Failed to load profile: ${response.body}");
    }
  }

  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0A00D8);
    const lightBlue = Color(0xFFEAF1FF);
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarSize = screenWidth * 0.28;
    final padding = screenWidth * 0.06;
    final fontSize = screenWidth * 0.045;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(
              color: primaryColor,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
          ? const Center(child: Text("Failed to load profile"))
          : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        child: Column(
          children: [
            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundColor: lightBlue,
                  child: Icon(Icons.person, size: avatarSize * 0.6, color: primaryColor),
                ),
                if (userData?['isVerified'] == true)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.verified, color: Colors.white, size: 18),
                  ),
              ],
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              userData?['fullName'] ?? "Unknown",
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            const Text("Verified User", style: TextStyle(color: Colors.grey)),

            SizedBox(height: screenWidth * 0.1),
            _infoTile("Email", userData?['email'] ?? "-", Icons.email_outlined, fontSize),
            SizedBox(height: screenWidth * 0.03),
            _infoTile("Mobile", userData?['mobileNo'] ?? "-", Icons.phone_outlined, fontSize),
            SizedBox(height: screenWidth * 0.03),
            _infoTile("Date of Birth", userData?['dob'] ?? "-", Icons.cake_outlined, fontSize),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value, IconData icon, double fontSize) {
    const primaryColor = Color(0xFF0A00D8);
    const lightBlue = Color(0xFFEAF1FF);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: fontSize * 0.7, vertical: fontSize * 0.8),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black54)),
                Text(value, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
