import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyhive/screens/ticket_screen.dart';
import '../error/7_error_2.dart';
import '../utils/app_styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'bottom_bar.dart';
import 'package:flutter/rendering.dart';
import 'increment.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import 'package:skyhive/stripe_payment/stripe_keys.dart';


class FormScreen extends StatefulWidget {
  final String? departureValue;
  final String? arrivalValue;

  const FormScreen({Key? key, this.departureValue, this.arrivalValue})
      : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();

  static Future<void> makePayment(String valueChoose, String currency) async {
    int amount;

    if (valueChoose == 'Economic') {
      amount = 1200;
    } else if (valueChoose == 'Business') {
      amount = 3500;
    } else if (valueChoose == 'Premiere') {
      amount = 10500;
    } else {
      throw Exception('Invalid valueChoose');
    }

    try {
      String clientSecret = await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Tatsinkou',
        ));
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post('https://api.stripe.com/v1/payment_intents',
        options: Options(headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        }),
        data: {
          'amount': amount,
          'currency': currency,
        });
    return response.data["client_secret"];
  }
}

class _FormScreenState extends State<FormScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    initializeNotifications();
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
  void initializeNotifications() async {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/stripe.png');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  late int amount;
  String getFirstValues(String valueChoose) {
    if (valueChoose == 'Economic') {
      amount = 1200;
    } else if (valueChoose == 'Business') {
      amount = 3500;
    } else if (valueChoose == 'Premiere') {
      amount = 10500;
    } else {
      throw Exception('Invalid valueChoose');
    }
    return 'Values set successfully';
  }

  Future<void> Payment() async {
    await _showNotification(
      "Paiement Stripe effectué",
      "Txn: Credit Compte: 0XX..11X Valeur: 10500USD Des: TAXI FEES INTERNS/AUG 2023 Date:19-Aug-2023 10:45 Solde:  51,667.00USD COVID19 est réel #StaySafe",
    );
  }
  Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics =  AndroidNotificationDetails(
      'my_notification_channel',
      'Notifications importantes',
      channelDescription: 'Paiement effectué',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics, payload: 'item x',
    );
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
  int incrementCount = 0;
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
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF526799),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton(
                            hint: const Text("Select Class:"),
                            icon: const Icon(Icons.arrow_drop_down),
                            dropdownColor: Colors.grey.shade300,
                            style: const TextStyle(color: Colors.black, fontSize: 19),
                            iconSize: 30,
                            isExpanded: true,
                            underline: const SizedBox(),
                            value: valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoose = newValue.toString();
                                FormScreen.makePayment(valueChoose, "USD"); // Appel de makePayment avec valueChoose et la devise souhaitée
                              });
                            },
                            items: listItem.map((valueItem) {
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
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF526799), width: 1.5),
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
                          onPressed: () async {
                            if (departureController.text.isEmpty||
                                arrivalController.text.isEmpty ||
                                passengerController.text.isEmpty) {
                              Get.snackbar("About Ticket", "Ticket message",
                                  backgroundColor: Colors.redAccent,
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: const Text(
                                    "Please fill in the arrival,departure and name fields",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  messageText: const Text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  ));
                            } else  {
                              if (
                              (departureController.text.toLowerCase() == "douala-cameroun" || arrivalController.text.toLowerCase() == "douala-cameroun") ||
                                  (arrivalController.text.toLowerCase() == "yaounde-cameroun" || departureController.text.toLowerCase() == "yaounde-cameroun") ||
                                  (departureController.text.toLowerCase() == "london-england" || arrivalController.text.toLowerCase() == "london-england") ||
                                  (departureController.text.toLowerCase() == "paris-france" || arrivalController.text.toLowerCase() == "paris-france") ||
                                  (arrivalController.text.toLowerCase() == "dhaka-bangladesh" || departureController.text.toLowerCase() == "dhaka-bangladesh") ||
                                  (departureController.text.toLowerCase() == "shanghai-chine" || arrivalController.text.toLowerCase() == "shanghai-chine") ||
                                  (departureController.text.toLowerCase() == "pekin-chine" || arrivalController.text.toLowerCase() == "pekin-chine") ||
                                  (arrivalController.text.toLowerCase() == "berlin-allemagne" || departureController.text.toLowerCase() == "berlin-allemagne") ||
                                  (departureController.text.toLowerCase() == "abuja-nigeria" || arrivalController.text.toLowerCase() == "abuja-nigeria") ||
                                  (departureController.text.toLowerCase() == "brazzaville-congo" || arrivalController.text.toLowerCase() == "brazzaville-congo") ||
                                  (arrivalController.text.toLowerCase() == "bruxelles-belgique" || departureController.text.toLowerCase() == "bruxelles-belgique") ||
                                  (departureController.text.toLowerCase() == "niamey-niger" || arrivalController.text.toLowerCase() == "niamey-niger") ||
                                  (departureController.text.toLowerCase() == "tunis-tunisie" || arrivalController.text.toLowerCase() == "tunis-tunisie") ||
                                  (departureController.text.toLowerCase() == "bamako-mali" || arrivalController.text.toLowerCase() == "bamako-mali") ||
                                  (arrivalController.text.toLowerCase() == "ottawa-canada" || departureController.text.toLowerCase() == "ottawa-canada") ||
                                  (departureController.text.toLowerCase() == "tokyo-japon" || arrivalController.text.toLowerCase() == "tokyo-japon")) {
                                String departure = departureController.text;
                                String arrival = arrivalController.text;
                                String passenger = passengerController.text;
                                saveData(departure, arrival, passenger);
                                saveFormData;
                                await FormScreen.makePayment(valueChoose, "USD");
                                Get.to(() =>BottomBar(selectedIndex: 2,
                                    departure: departureController.text,
                                    arrival: arrivalController.text,
                                    dates: formattedDate,
                                    heure: valueChoose2,
                                    passengerController: passengerController.text,
                                    valueChoose: valueChoose), arguments:TicketScreen(
                                  departure: departureController.text,
                                  arrival: arrivalController.text,
                                  dates: formattedDate,
                                  heure: valueChoose2,
                                  passengerController: passengerController.text,
                                  valueChoose: valueChoose,
                                ));
                                await Payment();
                              } else {
                                Get.to(() => Error2Screen());
                              }
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

  Future<void> saveData(String departure, String arrival, String passenger) async {
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

  void increment() {
    setState(() {
      incrementCount++;
    });
  }
}
