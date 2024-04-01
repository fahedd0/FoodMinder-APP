import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_2_implementation/forget_password/forget_password.dart';
import 'package:phase_2_implementation/main_screenF/main_navigation.dart';
import 'package:phase_2_implementation/sign_up/sign_up.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  var errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                kToolbarHeight,
          ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/b_g.png'), // Ensure this path is correct
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 100.0),
                    Image.asset(
                      'assets/fm.png', // Ensure this path is correct
                      width: 200, // Adjust the width as needed
                      height: 100, // Adjust the height as needed
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'HouseHold waste management app',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 48.0),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      errorText,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          var loginResult = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          if (loginResult.user != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainNavigation(),
                              ),
                            );
                          }
                          // else {loginResult.}
                        } on FirebaseAuthException catch (e, s) {
                          setState(() {
                            errorText = e.message ?? "Sing Up FAilED!!!";
                          });
                          print(e);
                          print(s);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(
                            103, 58, 183, 1), // Adjust as needed
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    // TextButton(
                    //   onPressed: () {
                    //     // Implement additional functionality as needed
                    //   },
                    //   style: TextButton.styleFrom(
                    //     foregroundColor: Colors.deepPurple, // Adjust as needed
                    //   ),
                    //   child: const Text('UAE PASS'),
                    // ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ResetPassword(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black54,
                      ),
                      child: const Text('forgot password?'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black54,
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
