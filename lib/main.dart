import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phase_2_implementation/firebase_options.dart';
import 'package:phase_2_implementation/main_screenF/main_navigation.dart';
import 'package:phase_2_implementation/welcome/welcome.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FoodMinder());
}

class FoodMinder extends StatelessWidget {
  const FoodMinder({super.key});

  @override
  Widget build(BuildContext context) {
    var isUserLoggedIn = FirebaseAuth.instance.currentUser != null;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isUserLoggedIn ? const MainNavigation() : const Welcome(),
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SourceCodePro',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF673AB7)),
        useMaterial3: true,
      ),
    );
  }
}
