import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetDateScreen extends StatefulWidget {
  const SetDateScreen({super.key});

  @override
  State<SetDateScreen> createState() => _SetDateScreenState();
}

class _SetDateScreenState extends State<SetDateScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            const BackButton(), // Replace with your own back button if needed
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(40, 14, 40, 50),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement your done button handler
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            'Done',
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                letterSpacing: 3,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              children: [
                const Text(
                  'Set Date',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2),
                ),
                const SizedBox(height: 150),
                Text(
                  'Select date you want to be notified ! ',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 25,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date : ',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: DateFormat('yyyy-MM-dd').format(selectedDate),
                        contentPadding: const EdgeInsets.all(0),
                        border: buildOutlineInputBorder(context),
                        disabledBorder: buildOutlineInputBorder(context),
                        enabledBorder: buildOutlineInputBorder(context),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                ),
                const Expanded(
                    child: Icon(
                  Icons.date_range_outlined,
                  size: 40,
                )),
              ],
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/Picsart_24-03-19_15-07-34-003.png',
                    height: 250,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(.3), width: 2));
  }
}
