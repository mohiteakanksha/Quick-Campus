import 'package:flutter/material.dart';

import 'reset_email_sent_page.dart'; // Import the ResetEmailSentPage

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = ''; // Variable to hold the error message

  bool _isEmailValid(String email) {
    // A simple email validation
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      title: const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Enter your email address to reset your password.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Email Input for Forgot Password
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  border: const OutlineInputBorder(),
                  errorText: _errorMessage.isEmpty ? null : _errorMessage,
                ),
              ),
              const SizedBox(height: 20),

              // Reset Password Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A5DEF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  String email = _emailController.text;

                  if (!_isEmailValid(email)) {
                    setState(() {
                      _errorMessage = 'Please enter a valid email address.';
                    });
                  } else {
                    // Simulate a check to see if the email exists in your system
                    // This is a placeholder for actual logic to verify email from a database or backend
                    if (email == "test@example.com") { // Example of a valid email
                      // After reset logic, navigate to ResetEmailSentPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ResetEmailSentPage()),
                      );
                    } else {
                      setState(() {
                        _errorMessage = 'Incorrect email address.';
                      });
                    }
                  }
                },
                child: const Text(
                  "RESET PASSWORD",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
