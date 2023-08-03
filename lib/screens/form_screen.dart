import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../utils/app_styles.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'login_page.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);
  @override
  State<FormScreen> createState() => _FormScreenState();
}
class _FormScreenState extends State<FormScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String valueChoose = "Premiere";
  List<String> listItem = ["Premiere", "Business", "Economic"];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController departureController = TextEditingController();
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body:  Center(
        child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo.jpeg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "Departure",
                  hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                controller: arrivalController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                onChanged: onArrivalValueChanged,
                decoration: InputDecoration(
                  hintText: "Arrival",
                  hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "name",
                  hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "Passeport",
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF526799),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF526799),width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton(
                  hint: const Text("Select Class:"),
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.grey.shade300,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19
                  ),
                  iconSize: 30,
                  isExpanded: true,
                  underline: SizedBox(),
                  value: valueChoose,
                  onChanged: (newValue){
                    setState(() {
                      valueChoose = newValue.toString();
                    });
                  },
                  items: listItem.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF526799)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')} ${_selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                    SizedBox(
                    width: 140,
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF526799)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedDate != null
                                    ? DateFormat('dd MMM', 'en_US').format(selectedDate)
                                    : 'Aucune date sélectionnée',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                    // await makePayment();
                  Get.to(()=>LoginPage());
                  // if (_formkey.currentState!.validate()) {
                  //   await makePayment();
                  // } else {
                  //   await makePayment();
                  // }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF526799),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                  ),
                ),
                child: Text(
                  "Pay ticket",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ))),
      ),
    );
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  TextEditingController arrivalController = TextEditingController();

  void onArrivalValueChanged(String value) {
    // Logique à exécuter lorsque la valeur de l'arrivée change
  }
}
