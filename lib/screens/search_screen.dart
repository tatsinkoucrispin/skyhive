import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skyhive/utils/app_layout.dart';

import '../utils/app_styles.dart';
import '../widgets/double_text_widget.dart';
import '../widgets/icon_text_widget.dart';
import '../widgets/ticket_taps.dart';
import 'form_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final departureController = TextEditingController();
    final arrivalController = TextEditingController();

    final size = AppLayout.getSize(context);
    return  Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20),vertical: AppLayout.getHeight(20)),
        children: [
          Gap(AppLayout.getHeight(40)),
          Text("What are\nyou looking for?", style: Styles.headLineStyle1.copyWith(fontSize: AppLayout.getWidth(35)),),
          Gap(AppLayout.getHeight(20)),
          FittedBox(
            child: Container(
              padding: const EdgeInsets.all(3.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppLayout.getHeight(50),
                  ),
                  color: const Color(0xFFF4F6FD)),
              child: Row(
                children: [
                  /*
                airtime ticket
                 */
                  Container(
                    width: size.width * .44,
                    padding:
                        EdgeInsets.symmetric(vertical: AppLayout.getHeight(7)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(
                          AppLayout.getHeight(50),
                        )),
                        color: Colors.white),
                    child: const Center(
                      child: Text("Airline Tickets"),
                    ),
                  ),
                  /*
                hotels
                 */
                  Container(
                    width: size.width * .44,
                    padding:
                        EdgeInsets.symmetric(vertical: AppLayout.getHeight(7)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(
                          AppLayout.getHeight(50),
                        )),
                        color: Colors.transparent),
                    child: const Center(
                      child: Text("Hotels"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(AppLayout.getHeight(25)),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: AppLayout.getWidth(3), horizontal: AppLayout.getWidth(3)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppLayout.getWidth(10))
                ),
                child: Row(
                  children:[
                    Icon(Icons.flight_takeoff_rounded, color: const Color(0xFFBFC2DF),),
                    Gap(AppLayout.getWidth(10)),
                    Expanded(
                      child: TextFormField(
                        controller: departureController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Departure",
                          hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(AppLayout.getHeight(20)),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: AppLayout.getWidth(3), horizontal: AppLayout.getWidth(3)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppLayout.getWidth(10))
                ),
                child: Row(
                  children:[
                    Icon(Icons.flight_land_rounded, color: const Color(0xFFBFC2DF),),
                    Gap(AppLayout.getWidth(10)),
                    Expanded(
                      child: TextFormField(
                        controller: arrivalController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Arrival",
                          hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(AppLayout.getHeight(25)),
          GestureDetector(
            onTap: () {
              if (departureController.text.isNotEmpty && arrivalController.text.isNotEmpty ) {
                String departure = departureController.text;
                String arrival = arrivalController.text;
                saveData(departure, arrival);
                Get.to(() => FormScreen(
                      departureValue: departureController.text,
                      arrivalValue: arrivalController.text,
                    ));
              } else {
                Get.snackbar("About Ticket", "Ticket message",
                    backgroundColor: Colors.redAccent,
                    snackPosition: SnackPosition.BOTTOM,
                    titleText: Text(
                      "Please fill in the arrival and departure fields",
                      style: TextStyle(color: Colors.white),
                    ),
                    messageText: Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ));
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: AppLayout.getWidth(18),
                horizontal: AppLayout.getWidth(15),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF526799),
                borderRadius: BorderRadius.circular(AppLayout.getWidth(10)),
              ),
              child: Center(
                child: Text(
                  "tickets",
                  style: Styles.textStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Gap(AppLayout.getHeight(40)),
          const AppDoubleTextWidget(bigText: "Upcoming Flights", smallText: ""),
          Gap(AppLayout.getHeight(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: AppLayout.getHeight(425),
                width: size.width * 0.42,
                padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getHeight(15),
                    vertical: AppLayout.getWidth(15)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppLayout.getHeight(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 1,
                      spreadRadius: 1
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Container(
                      height: AppLayout.getHeight(190),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppLayout.getHeight(12)),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/areoport.jpg"
                          )
                        )
                      ),
                    ),
                    Gap(AppLayout.getHeight(12)),
                    Text(
                      "20% discount on the early booking of this flight. Don't miss out this chance",
                      style: Styles.headLineStyle2,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: size.width*0.44,
                        height: AppLayout.getHeight(200),
                        decoration: BoxDecoration(
                            color: Color(0xFF3AB8B8),
                            borderRadius:  BorderRadius.circular(AppLayout.getHeight(18))
                        ),
                        padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(15),horizontal: AppLayout.getHeight(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Discount\nfor survey", style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.bold,color: Colors.white),),
                            Gap(AppLayout.getHeight(10)),
                            Text("Take the survey about our services and get discount", style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 18),),
                          ],
                        ),
                      ),
                      Positioned(
                          right: -45,
                          top: -40,
                          child: Container(
                        padding: EdgeInsets.all(AppLayout.getHeight(30)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 18,color: Color(0xFF189999)),
                            color: Colors.transparent
                        ),
                      )
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeight(15)),
                  Container(
                    width: size.width*0.44,
                    height: AppLayout.getHeight(210),
                    padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(15), horizontal: AppLayout.getHeight(15)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppLayout.getHeight(18)),
                      color:const Color(0xFFEC6545)
                    ),
                    child: Column(
                      children: [
                        Text("Take love", style: Styles.headLineStyle2.copyWith(color: Colors.white, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                        Gap(AppLayout.getHeight(5)),
                        RichText(text: const TextSpan(
                          children: [
                            TextSpan(
                              text:'😍',
                              style: TextStyle(fontSize: 38)
                            ),
                            TextSpan(
                                text:'🥰',
                                style: TextStyle(fontSize: 50)
                            ),
                            TextSpan(
                                text:'😘',
                                style: TextStyle(fontSize: 38)
                            ),
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  Future<void> saveData(String departure, String arrival) async {
    try {
      CollectionReference collection =
      FirebaseFirestore.instance.collection('search');

      await collection.add({
        'departure': departure,
        'arrival': arrival,
      });
      print('Data saved successfully!');
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
