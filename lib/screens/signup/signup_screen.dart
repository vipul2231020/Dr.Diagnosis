import 'package:dr_diagnosis/common_files/network_url.dart';
import 'package:dr_diagnosis/screens/home/HealthApp.dart';
import 'package:dr_diagnosis/screens/login/login_page.dart';
import 'package:dr_diagnosis/screens/otp/OtpVerificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common_files/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';




class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Color primaryColor = AppTheme.dark; // Dark Blue
  final Color lightBlue = AppTheme.lightBlue; // Light Blue
  final TextEditingController fullName = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController dob = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
  Future<void> signup(String fullName, String email, String password,String mobile,String dob) async {
    final url = Uri.parse(networkUrl.signup);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
        'mobile' : mobile,
        'dob' : dob
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerificationScreen(email: email)));
      print('Signup successful');
    } else {
      Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpPage()));
      print('Signup failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.015),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios, size: screenWidth * 0.045, color: primaryColor),),
                    
                    SizedBox(width: screenWidth*.005,),
                    Text(
                      'New Account',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),

                _buildLabel("Full name", screenWidth),
                _buildTextField("Jhon Wick", false,fullName),

                _buildLabel("Password", screenWidth),
                _buildPasswordField(),

                _buildLabel("Email", screenWidth),
                _buildTextField("example@example.com", false,Email),

                _buildLabel("Mobile Number", screenWidth),
                _buildTextFieldMobile("1234567890", false,mobile),

                _buildLabel("Date Of Birth", screenWidth),
                _buildTextFieldDOB("DD / MM /YYY", false,dob),

                SizedBox(height: screenHeight * 0.015),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "By continuing, you agree to ",
                      style: TextStyle(fontSize: screenWidth * 0.03),
                      children: [
                        TextSpan(
                          text: "Terms of Use",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      signup(fullName.text,Email.text, password.text, mobile.text, dob.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.20,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: screenWidth * 0.042,color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),
                Center(
                  child: Text(
                    "or sign up with",
                    style: TextStyle(fontSize: screenWidth * 0.032),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(Icons.g_mobiledata, screenWidth),
                    SizedBox(width: screenWidth * 0.04),
                    _buildSocialIcon(Icons.facebook, screenWidth),
                    SizedBox(width: screenWidth * 0.04),
                    _buildSocialIcon(Icons.fingerprint, screenWidth),
                  ],
                ),

                SizedBox(height: screenHeight * 0.025),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "already have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.033,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: TextStyle(fontSize: screenWidth * 0.036, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTextField(String hintText, bool obscure,TextEditingController _controller) {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
  Widget _buildTextFieldMobile(String hintText, bool obscure,TextEditingController _controller) {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        maxLength: 10,
        controller: _controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 10) {
            return 'Enter a valid 10-digit mobile number';
          }
          return null;
        },
      ),
    );
  }
  Widget _buildTextFieldDOB(String hintText, bool obscure,TextEditingController _dobController) {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(10),

      ),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: _dobController,
            decoration: InputDecoration(
              //labelText: 'Date of Birth',

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none, // removes bottom line
                    ),

              //prefixIcon: Icon(Icons.calendar_today),

            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your date of birth';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: password,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: '************',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.025),
      decoration: BoxDecoration(
        color: lightBlue,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.blue[800], size: screenWidth * 0.055),
    );
  }
}
