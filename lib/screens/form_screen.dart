import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyhive/screens/ticket_screen.dart';
import '../utils/app_styles.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'increment.dart';
import 'login_page.dart';

class FormScreen extends StatefulWidget {
  final String? departureValue;
  final String? arrivalValue;

  const FormScreen({Key? key, this.departureValue, this.arrivalValue})
      : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    formattedDate = DateFormat('dd MMM').format(selectedDate);
    if (widget.departureValue != null) {
      departureController.text = widget.departureValue!;
    }
    if (widget.arrivalValue != null) {
      arrivalController.text = widget.arrivalValue!;
    }
    saveFormData();
  }
  TextEditingController departureController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  TextEditingController passengerController = TextEditingController();
  late String _selectedTime;
  late DateTime selectedDate;
  late String formattedDate;
  String valueChoose = "Premiere";
  List<String> listItem = ["Premiere", "Business", "Economic"];
  String valueChoose2 = "06:00AM";
  List<String> listItem2 = [
    "06:00AM",
    "07:00 AM",
    "08:00 AM",
    "09:00 AM",
    "12:00 AM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "06:00 AM",
    "07:00 PM",
    "08:00 PM",
    "09:00 PM",
    "10:00 PM"
  ];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IncrementModel(),
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: Center(
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
                          controller: departureController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                            hintText: "Departure",
                            hintStyle:
                                Styles.textStyle.copyWith(color: Colors.grey),
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
                          controller: passengerController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                            hintText: "name",
                            hintStyle:
                                Styles.textStyle.copyWith(color: Colors.grey),
                            //prefixIcon: Icon(icons),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFF526799),
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFF526799),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                      //   child: TextFormField(
                      //     keyboardType: TextInputType.text,
                      //     textInputAction: TextInputAction.next,
                      //     onEditingComplete: () => FocusScope.of(context).nextFocus(),
                      //     decoration: InputDecoration(
                      //       hintText: "Passeport",
                      //       //prefixIcon: Icon(icons),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         borderSide: const BorderSide(
                      //           color: Color(0xFF526799),
                      //           width: 1.5,
                      //         ),
                      //       ),
                      //       enabledBorder:OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         borderSide: const BorderSide(
                      //           color: Color(0xFF526799),
                      //           width: 1.5,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF526799), width: 1.5),
                              borderRadius: BorderRadius.circular(10)),
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
                          SizedBox(
                            width: 150,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF526799), width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton(
                                  hint: const Text("Heure vol:"),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  dropdownColor: Colors.grey.shade300,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 19),
                                  iconSize: 30,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: valueChoose2,
                                  onChanged: (newValue2) {
                                    setState(() {
                                      valueChoose2 = newValue2.toString();
                                    });
                                  },
                                  items: listItem2.map((valueItem2) {
                                    return DropdownMenuItem(
                                      value: valueItem2,
                                      child: Text(valueItem2),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: 140,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 10, right: 10),
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF526799), width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                // padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                      const SizedBox(height: 15.0),
                      Consumer<IncrementModel>(
                        builder: (context, model, _) {
                          return Text(
                            '',
                            style: TextStyle(fontSize: 1),
                          );
                        },
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (departureController.text.isNotEmpty &&
                                arrivalController.text.isNotEmpty &&
                                passengerController.text.isNotEmpty) {
                              String departure = departureController.text;
                              String arrival = arrivalController.text;
                              String passenger = passengerController.text;
                              saveData(departure, arrival, passenger);
                              saveFormData;
                              //Provider.of<IncrementModel>(context, listen: false).increment();
                              Get.offAll(()=>TicketScreen(
                                    passengerController: passengerController.text,
                                    valueChoose: valueChoose,
                                    departure: departureController.text,
                                    arrival: arrivalController.text,
                                    dates: formattedDate,
                                    heure: valueChoose2,
                                  ));
                              // Get.to(()=>LoginPage());
                            } else {
                              Get.snackbar("About Ticket", "Ticket message",
                                  backgroundColor: Colors.redAccent,
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: Text(
                                    "Please fill in the arrival,departure and name fields",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  messageText: Text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }
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
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        final String hour = pickedTime.hourOfPeriod.toString().padLeft(2, '0');
        final String minute = pickedTime.minute.toString().padLeft(2, '0');
        final String period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
        _selectedTime = '$hour:$minute $period';
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

  void saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('', departureController.text);
    prefs.setString('', arrivalController.text);
    prefs.setString('', formattedDate);
    prefs.setString('', passengerController.text);
    prefs.setString('', valueChoose);
    prefs.setString('', valueChoose2);
  }

  Future<void> saveData(
      String departure, String arrival, String passenger) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('ticket');

      await collection.add({
        'departure': departure,
        'arrival': arrival,
        'class': valueChoose,
        'heure': valueChoose2,
        'date': formattedDate,
        'passenger': passenger
      });
      print('Data saved successfully!');
    } catch (e) {
      print('Error saving data: $e');
    }
  }
  int incrementCount = 0;
  void increment() {
    setState(() {
      incrementCount++;
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedTime = TimeOfDay.now().format(context);
  }
}
