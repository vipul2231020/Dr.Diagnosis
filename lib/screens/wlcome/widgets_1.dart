import 'package:flutter/material.dart';

class LoginSignUpButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Log In Button
            ElevatedButton(
              onPressed: () {
                // TODO: Add login action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Deep blue
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
              ),
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                // TODO: Add signup action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100], // Light blue
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
