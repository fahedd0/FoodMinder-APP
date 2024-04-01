import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/text_scanner_controller.dart';

class GalleryView extends StatefulWidget {
  const GalleryView(
      {super.key,
      required this.title,
      this.text,
      required this.onImage,
      required this.onDetectorViewModeChanged});

  final String title;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final Function()? onDetectorViewModeChanged;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: widget.onDetectorViewModeChanged,
          //       child: Icon(
          //         Platform.isIOS ? Icons.camera_alt_outlined : Icons.camera,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: _galleryBody());
  }

  Widget _galleryBody() {
    return ListView(shrinkWrap: true, children: [
      _image != null
          ? SizedBox(
              height: 400,
              width: 400,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.file(_image!),
                ],
              ),
            )
          : const Icon(
              Icons.image,
              size: 200,
            ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          child: const Text('From Gallery'),
          onPressed: () => _getImage(ImageSource.gallery),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          child: const Text('Take a picture'),
          onPressed: () => _getImage(ImageSource.camera),
        ),
      ),
      if (_image != null)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text('Please select:\nScanned Text:\n'),
                ],
              ),
              GetBuilder<TextScannerController>(
                  init: TextScannerController(),
                  builder: (textController) {
                    List<String> result = widget.text?.split("\n") ?? [];

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              textController.selectedIndex = index;
                              textController.expDateController.text =
                                  result[index];
                              textController.update();
                              Get.back();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: textController.selectedIndex ==
                                                index
                                            ? Colors.red
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 25),
                                  child: Text(result[index]),
                                )),
                          );
                        });
                  })
            ],
          ),
        ),
    ]);
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage);
  }
}
