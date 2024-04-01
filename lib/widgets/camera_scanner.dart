
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../controller/text_scanner_controller.dart';

class CameraScanner extends StatefulWidget {
  const CameraScanner({super.key});

  @override
  State<CameraScanner> createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  MobileScannerController mobileScannerController = MobileScannerController();
  @override
  void initState() {
    mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    setState(() {

    });
    super.initState();
  }

  @override
  void dispose() {
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScannerController>(
      init: TextScannerController(),
        builder:(controller){
          return MobileScanner(
            // fit: BoxFit.contain,
            controller: mobileScannerController,
            onDetect: (capture) async {
              final List<Barcode> barcodes = capture.barcodes;
              // final Uint8List? image = capture.image;
              if(barcodes.isNotEmpty && barcodes.first.rawValue
                  != null && barcodes.first.rawValue != "") {
                Navigator.pop(context);
                controller.nameController.text = barcodes.first.rawValue??"";
                controller.update();
              }
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
              }
            },
          );
        }
    );
  }
}
