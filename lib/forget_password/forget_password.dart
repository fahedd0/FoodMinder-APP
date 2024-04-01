import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                kToolbarHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const Text(
                  'Reset password',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'New password :',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm password :',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                // Add your image below the reset password text
                const Spacer(),
                Image.asset(
                  'assets/mobile-password-forgot.png', // Replace with your image asset path
                  width: 250,
                  height: 250,
                ),
                const Spacer(),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.deepPurple, // Button background color
                      minimumSize:
                          const Size(double.infinity, 50), // Button size
                    ),
                    onPressed: () {
                      // Add reset password functionality
                    },
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
