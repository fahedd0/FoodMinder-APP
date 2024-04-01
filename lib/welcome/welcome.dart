import 'package:flutter/material.dart';
import 'package:phase_2_implementation/sign_up/sign_up.dart';
import 'package:phase_2_implementation/log_in/log_in.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 75),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: InkWell(
                onTap: () {
                  launchUrl(Uri.parse('https://flutter.dev'));
                },
                child: Image.asset('assets/HomePage1.png'),
              ), // Replace with your asset image path
            ),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'ABOUT',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Our aim is to reduce food waste, and ensure that food is either consumed in the right way or donated to competent authorities.',
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
            const SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  //flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple, // Button text color
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(width: 20), // Spacing between the buttons
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      //Navigate to login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogIn()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      side: const BorderSide(
                          color: Colors.deepPurple), // Border color
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
      ),*/
    );
  }
}
