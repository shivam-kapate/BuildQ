import 'package:flutter/material.dart';

import 'main.dart';// Make sure your home class is in this file or main.dart

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. App Branding
            Center(
              child: Text(
                "BUILDQ",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Colors.indigo,
                ),
              ),
            ),
            SizedBox(height: 50),

            // 2. Welcome Text
            Text("Welcome!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("Enter your phone number to continue", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 30),

            // 3. Phone Input Field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FB),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.indigo.withOpacity(0.1)),
              ),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone, color: Colors.indigo),
                  hintText: "Phone Number",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // 4. Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // For now, we just go to the Home Page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text("GET OTP", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            
            SizedBox(height: 20),
            Center(child: Text("Or login with Social Media", style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}
