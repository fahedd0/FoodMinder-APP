//item_specifications_page
import 'package:flutter/material.dart';
import 'package:phase_2_implementation/firebase/firebase_manager.dart';
import 'package:phase_2_implementation/models/cart_item.dart';
import 'package:phase_2_implementation/models/food_category.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:phase_2_implementation/my_cart/my_cart.dart';

class FoodItemPage extends StatefulWidget {
  final FoodCategory foodCat;
  const FoodItemPage({
    super.key,
    required this.foodCat,
  });

  @override
  State<FoodItemPage> createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  String barcode = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  DateTime? _expiryDate;
  bool _weightSelected = false;
  bool _quantitySelected = false;
  DateTime? reminderDateTime;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _scanBarcode() async {
    try {
      // ignore: unused_local_variable
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
      barcode = barcodeScanRes;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _pickExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date set to today
      firstDate: DateTime(2018, 01, 01), // Earliest possible date
      lastDate: DateTime(2030, 12, 31), // Latest possible date
    );
    if (picked != null && picked != DateTime.now()) {
      _expiryDate = picked;
      _expiryDateController.text = DateFormat(DateFormat.YEAR_MONTH_DAY).format(_expiryDate!);
    }
  }

  Future<void> _scanExpiryDate() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      String expiryDateText = ""; // Placeholder for extracted expiry date text

      // Example logic to find a date in the recognized text
      for (TextBlock block in recognizedText.blocks) {
        final String text = block.text;
        if (RegExp(r'\d{4}-\d{2}-\d{2}').hasMatch(text)) {
          var match = RegExp(r'\d{4}-\d{2}-\d{2}').firstMatch(text);
          expiryDateText = text.substring(match!.start, match.end);
          break; // Stop looking once a date is found
        }
      }
      var date = DateTime.tryParse(expiryDateText);
      if (date != null && date != DateTime.now()) {
        _expiryDate = date;
        _expiryDateController.text = DateFormat(DateFormat.YEAR_MONTH_DAY).format(_expiryDate!);
      }
    } finally {
      textRecognizer.close(); // Don't forget to close the recognizer when done
    }
  }

  Future<void> _pickReminderDateTime() async {
    // First, let the user pick a date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)), // Suggest next day
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate == null) return; // User canceled the date picker

    // Then, let the user pick a time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return; // User canceled the time picker

    // Combine the date and time into a single DateTime
    setState(() {
      reminderDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });

    // Here, you would also schedule the notification using your preferred notification package
  }

  bool _validateFields() {
    // Case 1: Check if all fields are empty
    if (_nameController.text.isEmpty &&
        !_weightSelected &&
        !_quantitySelected &&
        _expiryDate == "Expiry date") {
      _showErrorMessage(
        "All fields are empty",
        "You must fill in the details for the item before confirming.",
        cancelAction: () {
          Navigator.of(context).pop();
        }, // Close the dialog
      );
      return false;
    }

    // Case 2: Check if neither Weight nor Quantity is selected
    if (!_weightSelected && !_quantitySelected) {
      _showErrorMessage(
        "Weight or Quantity Required",
        "Please select and fill either Weight or Quantity.",
        cancelAction: () {
          Navigator.of(context).pop(); // This will just close the dialog
        }, // You can provide actions or leave it empty to only close the dialog
      );
      return false;
    }

    // Case 3: Check if Weight or Quantity is zero
    if ((_weightSelected && _weightController.text == '0') ||
        (_quantitySelected && _quantityController.text == '0')) {
      _showErrorMessage(
        "Invalid Input",
        "Weight or Quantity can't be zero.",
        cancelAction: () {
          Navigator.of(context).pop();
        }, // This will just close the dialog
      );
      return false;
    }

    // Case 4: Check if Expiry Date is today or past
    if (_expiryDate == null) {
      return false;
    }
    //   DateTime selectedDate = DateFormat('yyyy-MM-dd').parse(_expiryDate);
    //   DateTime now = DateTime.now();
    //   DateTime today = DateTime(now.year, now.month, now.day);

    //   if (selectedDate.isAtSameMomentAs(today) || selectedDate.isBefore(today)) {
    //     _showExpiryDialog();
    //     return false;
    //   }
    // }

    return true;
  }

  void _showErrorMessage(String title, String content,
      {VoidCallback? cancelAction, VoidCallback? continueEditingAction}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                if (cancelAction != null) {
                  cancelAction();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Cancel'),
            ),
            if (continueEditingAction != null)
              TextButton(
                onPressed: continueEditingAction,
                child: const Text('Continue Editing'),
              ),
          ],
        );
      },
    );
  }

  void _showExpiryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Item Expired'),
        content: const Text('The item is already expired, would you still like to keep it or donate?'),
        actions: [
          TextButton(
            onPressed: () {
              // Resume app functionalities normally;
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () {
              // Redirect to Donate food page, and add item there;
              // You need to implement this navigation logic
            },
            child: const Text('Donate'),
          ),
        ],
      ),
    );
  }

  void _confirmItem() async {
    var item = CartItem(
      category: widget.foodCat,
      name: _nameController.text,
      barcode: barcode,
      quantity: double.tryParse(_quantityController.text) ?? 0,
      weight: double.tryParse(_weightController.text) ?? 0,
      expiryDate: _expiryDate!,
    );
    await FirebaseManager.addItemToCart(item);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const ShoppingCartPage(),
    ));
    // Code for confirming the item after all validations pass
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform.translate(
          offset: const Offset(0, 0),
          child: const Text(
            'Add Food item',
            style: TextStyle(
                fontWeight: FontWeight.w200,
                color: Colors.black,
                fontSize: 22.0), //Black (thickest text)
          ),
        ),
        actions: [
          IconButton(
            icon: Transform.translate(
              offset: const Offset(0, 0),
              child: Image.asset('assets/cart.png', width: 44, height: 44),
            ),
            onPressed: () {
              //Navigate to cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShoppingCartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Aligns children along the main axis (top to bottom in a column)
          crossAxisAlignment: CrossAxisAlignment.center, // Centers children horizontally.
          children: <Widget>[
            Text(
              widget.foodCat.categoryName,
              style: const TextStyle(
                fontSize: 33.0, // Adjust the text size as needed
                fontWeight: FontWeight.w900, // Adjust the text weight/thickness as needed
                color: Colors.black, // This sets the color of the text
              ),
            ),

            SizedBox(
              width: 250, // Adjust the width as needed
              height: 250, // Adjust the height as needed
              child: Center(
                // Center the image within the SizedBox
                child: Image.network(
                  widget.foodCat.categoryImage,
                  fit: BoxFit.contain, // This will maintain the aspect ratio of the image
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(
                MdiIcons.barcodeScan,
                color: Colors.white,
              ),
              label: const Text(
                'Scan Barcode',
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: _scanBarcode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Use backgroundColor instead of primary
                foregroundColor: Colors.white, // Use foregroundColor instead of onPrimary
                fixedSize: const Size(260, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: const TextStyle(
                  fontSize: 18.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    title: const Text(
                      "Weight",
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    value: _weightSelected,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _weightSelected = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text(
                      "Quantity",
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    value: _quantitySelected,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _quantitySelected = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            if (_weightSelected || _quantitySelected)
              Row(
                children: [
                  if (_weightSelected)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextField(
                          controller: _weightController,
                          decoration: InputDecoration(
                            labelText: 'specify g/Kg',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                    ),
                  if (_quantitySelected)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: _quantityController,
                          decoration: InputDecoration(
                            labelText: 'specify units',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                ],
              ),

            const SizedBox(height: 20),

            // Text Field for displaying and selecting the expiry date
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickExpiryDate, // Open the date picker when the field is tapped
                    child: IgnorePointer(
                      // Prevents the keyboard from showing
                      child: TextField(
                        controller: _expiryDateController, // Display the selected expiry date
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          hintText: 'Tap to select date', // Provides a hint to the user
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _pickExpiryDate,
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _scanExpiryDate,
                  color: Colors.deepPurple,
                ),
              ],
            ),

            const SizedBox(height: 20),

            //add the "Remind Me" button:
            ElevatedButton(
              onPressed: () {
                // Call the function to show date and time picker dialogs
                _pickReminderDateTime();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 240, 236, 154),
                foregroundColor: Colors.white,
                fixedSize: const Size(200, 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Remind Me?',
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w400),
              ),
            ),

            // Reminder DateTime Display and Edit button
            if (reminderDateTime != null) // Check if a reminder is set
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "We will remind you on ${DateFormat('yyyy-MM-dd').format(reminderDateTime!)} at ${DateFormat('HH:mm').format(reminderDateTime!)}.",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 77, 76, 76),
                              ),
                            ),
                            TextSpan(
                              text: 'Edit?',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 255, 0, 0),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = _pickReminderDateTime,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20), // Space between buttons

            // Confirm Item Button
            ElevatedButton(
              onPressed: () {
                if (_validateFields()) {
                  _confirmItem();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                fixedSize: const Size(200, 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Confirm Item',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
