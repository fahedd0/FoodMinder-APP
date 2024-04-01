import 'package:flutter/material.dart';
import 'package:phase_2_implementation/constantns/app_colors.dart';
import 'package:get/get.dart';
import 'package:phase_2_implementation/log_in/log_in.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 40),
            child: Stack(
              children: [
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/custom_shape.png",
                    color: const Color(0xffF5F2FB),
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/settings_icon.png",
                        height: 65,
                        width: 65,
                        color: AppColors.mainColor,
                      ),
                      Text(
                        "Settings",
                        style: Get.theme.textTheme.displaySmall
                            ?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 4, height: 2.5),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: Get.width * .75,
              height: Get.height * .075,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.mainColor.withOpacity(.5),
              ),
              child: Center(
                child: Text(
                  "Live Chat",
                  style: Get.theme.textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: Get.width * .75,
              height: Get.height * .075,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffA26EFF).withOpacity(.85),
              ),
              child: Center(
                child: Text(
                  "Contact Us",
                  style: Get.theme.textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: InkWell(
              onTap: () {
                Get.to(() => const LogIn());
              },
              child: Container(
                width: Get.width * .75,
                height: Get.height * .075,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xff7F58D4),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: Get.theme.textTheme.displaySmall
                        ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
