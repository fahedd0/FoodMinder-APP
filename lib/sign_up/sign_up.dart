import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_2_implementation/firebase/firebase_manager.dart';
import 'package:phase_2_implementation/log_in/log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var hidePassword = true;
  var hideConfirmPassword = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isEmail(String input) =>
      RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(input);

  var errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 115.0),
                          Image.asset(
                            'assets/fm.png', // Make sure the path is correct
                            width: 200, // Adjust the width as needed
                            height: 100, // Adjust the height as needed
                          ),
                          const SizedBox(height: 0.0),
                          const Text(
                            'HouseHold waste management app',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                              height: 10), // Space above "Sign Up" text
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20), // Additional spacing
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: "E-Mail",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !isEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                    () => hidePassword = !hidePassword),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              labelText: "Password",
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            errorText,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                              height: 10), // Space before the "SIGN UP" button
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );

                                  var singUpResult = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  await singUpResult.user
                                      ?.updateDisplayName(nameController.text);

                                  if (singUpResult.user != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LogIn(),
                                      ),
                                    );
                                  }
                                }
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
                              backgroundColor: Colors.deepPurple,
                              minimumSize: const Size(150, 40),
                            ),
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 0), // Space after "SIGN UP" button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already Have an account?"),
                              TextButton(
                                onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogIn()),
                                ),
                                child: const Text("Login"),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
