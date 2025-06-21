import 'package:dr_diagnosis/common_files/network_url.dart';
import 'package:dr_diagnosis/screens/home/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../common_files/NavigatorInstagram.dart';
import '../../common_files/colors.dart';
import '../home/HealthApp.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key,required, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Future<void> _verifyOtp() async {
    final otp = _controllers.map((e) => e.text).join();
    final url = Uri.parse(networkUrl.Otpverification);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": widget.email,
        "otp": otp,
      }),
    );

    if (response.statusCode == 200) {
      // Navigate to dashboard or home
      Navigator.of(context).push(createInstagramRoute(MainHomePage()));

    } else {
      final body = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(body['error'] ?? 'Failed to verify OTP')),
      );
    }
  }


  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final Color primaryColor = AppTheme.dark; // Dark Blue
    final Color lightBlue = AppTheme.lightBlue;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  'Verify OTP',
                  style: TextStyle(
                    fontSize: width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Text(
                  'Enter the 6-digit code sent to your email or phone number',
                  style: TextStyle(fontSize: width * 0.04, color: Colors.black54),
                ),
                SizedBox(height: height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: width * 0.12,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) => _onOtpChanged(value, index),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: lightBlue,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: height * 0.06),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _verifyOtp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.2,
                        vertical: height * 0.02,
                      ),
                    ),
                    child: Text(
                      'Verify',
                      style: TextStyle(fontSize: width * 0.045,color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: Trigger resend OTP
                    },
                    child: Text(
                      'Didn\'t get code? Resend',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
