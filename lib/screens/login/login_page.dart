import 'package:dr_diagnosis/common_files/colors.dart';
import 'package:dr_diagnosis/common_files/network_url.dart';
import 'package:dr_diagnosis/screens/home/HealthApp.dart';
import 'package:dr_diagnosis/screens/home/Home_page.dart';
import 'package:dr_diagnosis/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final Color primaryColor = AppTheme.dark; // Dark Blue
  final Color lightBlue = AppTheme.lightBlue; // Light Blue
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> login(String email, String password) async {
    final url = Uri.parse(networkUrl.login);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'access_token', value: data['accessToken']);
      await storage.write(key: 'refresh_token', value: data['refreshToken']);
      print('Login success: ${response.body} , ${response.statusCode}');
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainHomePage()));
      return true;
    }

    print('Login failed: ${response.body} , ${response.statusCode}');
    return false;
  }

  bool _obscurePassword = true;


  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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

                    SizedBox(width: screenWidth*0.05,),
                    Text(
                      'Log In',
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
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                _buildLabel("Email or Mobile Number", screenWidth),
                _buildTextField("example@example.com", false,email),

                _buildLabel("Password", screenWidth),
                _buildPasswordField(),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      login(email.text, password.text);
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
                      'Log In',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.033,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
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
