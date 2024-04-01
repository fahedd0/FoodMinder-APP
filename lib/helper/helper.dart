import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class HelperWidgets {


  static loading() {
    Get.closeCurrentSnackbar();
    Get.closeAllSnackbars();
    if (Platform.isIOS) {
      Get.dialog(
           const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             CircularProgressIndicator()
            ],
          ),
          barrierColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.6),
          barrierDismissible: true);
    } else {
      Get.dialog(
           const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator()
                ),
              ),
            ],
                     ),
          barrierColor:
          Colors.black54.withOpacity(0.5),
          barrierDismissible: false);
    }
  }
  void showHint(String title, message) {
    HapticFeedback.mediumImpact();
    Get.closeCurrentSnackbar();
    Get.closeAllSnackbars();
    Get.snackbar(title, '$message',
        icon: Icon(
          Icons.check_circle,
          color: Colors.green.shade800,
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 3));
  }

  void showError(String title, message) {
    HapticFeedback.mediumImpact();
    Get.closeCurrentSnackbar();
    Get.closeAllSnackbars();
    Get.snackbar(title, '$message',
        icon: const Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 3));
  }

}