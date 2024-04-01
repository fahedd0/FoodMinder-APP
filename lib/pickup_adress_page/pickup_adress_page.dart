import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:phase_2_implementation/home_screen/home_screen.dart';

class PickupAddressPage extends StatefulWidget {
  @override
  _PickupAddressPageState createState() => _PickupAddressPageState();
}

class _PickupAddressPageState extends State<PickupAddressPage> {
  String selectedType = 'Apartment';
  PhoneNumber selectedPhoneNumber = PhoneNumber(isoCode: 'AE');
  DateTime? selectedDateTime;
  bool saveAddress = false;
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(_updatePhoneNumber);
  }

  @override
  void dispose() {
    phoneNumberController.removeListener(_updatePhoneNumber);
    phoneNumberController.dispose();
    super.dispose();
  }

  void _updatePhoneNumber() {
    final number = PhoneNumber(
        isoCode: selectedPhoneNumber.isoCode,
        phoneNumber: phoneNumberController.text);
    setState(() {
      selectedPhoneNumber = number;
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Format the selected date and time
        String formattedDate = selectedDateTime != null
            ? DateFormat('dd/MM/yyyy').format(selectedDateTime!)
            : 'N/A';
        String formattedTime = selectedDateTime != null
            ? DateFormat('HH:mm').format(selectedDateTime!)
            : 'N/A';

        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text(
              'You have successfully scheduled a pick up on $formattedDate at $formattedTime.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('Confirm & exit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog and return to the page
              },
              child: const Text('Return & edit'),
            ),
          ],
        );
      },
    );
  }

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pick up address')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Address type buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Apartment', 'House', 'Office']
                    .map((type) => _addressTypeButton(type))
                    .toList(),
              ),
              // Address form fields
              _addressFormField('Emirate. Area'),
              Row(
                children: [
                  Expanded(
                    child: _addressFormField(selectedType == 'Apartment'
                        ? 'Apt.no'
                        : selectedType == 'House'
                            ? 'House.num'
                            : 'Company'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _addressFormField('Floor'),
                  ),
                ],
              ),
              _addressFormField('Street name'),
              _addressFormField('Building name'),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  setState(() {
                    selectedPhoneNumber = number;
                  });
                },
                onInputValidated: (bool value) {},
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                initialValue: selectedPhoneNumber,
                textFieldController: phoneNumberController,
                formatInput: false,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: const OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              _addressFormField('Additional directions (optional)'),
              ElevatedButton(
                onPressed: _pickDateTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 240, 234, 179),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text(
                  'Pick Date and time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (selectedDateTime != null)
                Text(
                    'You have selected pickup time to be on ${DateFormat('dd/MM/yyyy').format(selectedDateTime!)} at ${DateFormat('HH:mm').format(selectedDateTime!)}'),
              CheckboxListTile(
                title: const Text('Save Address for future use?'),
                value: saveAddress,
                onChanged: (bool? value) {
                  setState(() {
                    saveAddress = value ?? false;
                  });
                },
              ),
              // Confirm Address button
              ElevatedButton(
                onPressed: _showConfirmationDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text(
                  'Confirm Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _addressFormField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.deepPurple.withAlpha(50),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _addressTypeButton(String type) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedType = type;
        });
      },
      style: ElevatedButton.styleFrom(
        // Change the background color based on whether this type is selected
        backgroundColor: selectedType == type ? Colors.deepPurple : Colors.grey,
        foregroundColor: Colors.white, // Text color
      ),
      child: Text(type),
    );
  }
}
