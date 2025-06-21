import 'package:dr_diagnosis/common_files/NavigatorInstagram.dart';
import 'package:flutter/material.dart';
import 'package:dr_diagnosis/common_files/colors.dart';
import 'package:dr_diagnosis/screens/login/login_page.dart';
import 'package:dr_diagnosis/screens/signup/signup_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.15),
              Image.asset('assets/logo.png', width: height * 0.4),
              SizedBox(height: height * 0.02),
              Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: height * 0.07,
                  color: AppTheme.dark,
                ),
              ),
              SizedBox(height: height * 0.06),

              // Log In Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(createInstagramRoute(LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.dark,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.025,
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(createInstagramRoute(SignUpPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightBlue,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppTheme.dark,
                    fontSize: height * 0.025,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
