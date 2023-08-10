import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:skyhive/utils/app_layout.dart';
import 'package:skyhive/widgets/thick_container.dart';
import '../utils/app_styles.dart';
import 'package:intl/intl.dart';
import '../widgets/column_layout.dart';
import 'dart:math';
import '../widgets/layout_builder_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketViews extends StatefulWidget {

  final bool? isColor;
  String departure;
  String arrival;
  String heure;
  String date;

  TicketViews({Key? key,
    this.isColor,
    required this.departure,
    required this.arrival,
    required this.heure,
    required this.date}): super(key: key);
  @override
  _TicketViewsState createState() => _TicketViewsState();
}
class _TicketViewsState extends State<TicketViews> {
  @override
  Widget build(BuildContext context) {
    int generateRandomNumber(List<int> generatedNumbers) {
      Random random = Random();
      int randomNumber = random.nextInt(100) + 1;

      while (generatedNumbers.contains(randomNumber)) {
        randomNumber = random.nextInt(100) + 1;
      }

      generatedNumbers.add(randomNumber);
      return randomNumber;
    }
    List<int> generatedNumbers = [];
    late SharedPreferences _prefs;
    String firstText = generateRandomNumber(generatedNumbers).toString();
    String secondText = "Number";
    DateTime parsedDate = DateTime.parse(widget.date);
    // String formattedDate = DateFormat('dd MMM').format(parsedDate);
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width * 0.85,
      height: AppLayout.getHeight(GetPlatform.isAndroid == true ? 167 : 169),
      child: Container(
        margin: EdgeInsets.only(right: AppLayout.getHeight(16)),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*
              showing the blue part of the card/ticket
              */
              Container(
                decoration: BoxDecoration(
                    color: widget.isColor == null ? Color(0xFF526799) : Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppLayout.getHeight(21)),
                        topRight: Radius.circular(AppLayout.getHeight(21)))),
                padding: EdgeInsets.all(AppLayout.getHeight(16)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.departure.substring(0, 3).toUpperCase(),
                          style: widget.isColor == null
                              ? Styles.headLineStyle3
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle3,
                        ),
                        Expanded(child: Container()),
                        ThickContainer(isColor: true),
                        Expanded(
                            child: Stack(
                          children: [
                            SizedBox(
                              height: AppLayout.getHeight(24),
                              child: AppLayoutBuilderWidget(sections: 6),
                            ),
                            Center(
                              child: Transform.rotate(
                                  angle: 1.5,
                                  child: Icon(Icons.local_airport_rounded,
                                      color: widget.isColor == null
                                          ? Colors.white
                                          : Color(0xFF8ACCF7))),
                            ),
                          ],
                        )),
                        ThickContainer(isColor: true),
                        Expanded(child: Container()),
                        Text(
                            widget.arrival.substring(0, 3).toUpperCase(),
                            style: widget.isColor == null
                                ? Styles.headLineStyle3.copyWith(
                                    color: Colors.white,
                                  )
                                : Styles.headLineStyle3)
                      ],
                    ),
                    const Gap(3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: AppLayout.getWidth(100),
                          child: Text(
                            widget.departure,
                            style: widget.isColor == null
                                ? Styles.headLineStyle4
                                    .copyWith(color: Colors.white)
                                : Styles.headLineStyle4,
                          ),
                        ),
                        Text(
                          "8H 20M",
                          style: widget.isColor == null
                              ? Styles.headLineStyle3
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle3,
                        ),
                        SizedBox(
                          width: AppLayout.getWidth(100),
                          child: Text(
                            widget.arrival,
                            textAlign: TextAlign.end,
                            style: widget.isColor == null
                                ? Styles.headLineStyle4
                                    .copyWith(color: Colors.white)
                                : Styles.headLineStyle4,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              /*
              * showing the orange part of the card/ticket
              * */
              Container(
                color: widget.isColor == null ? Styles.orangeColor : Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      height: AppLayout.getHeight(20),
                      width: AppLayout.getWidth(10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: widget.isColor == null
                                ? Colors.grey.shade200
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                (constraints.constrainWidth() / 15).floor(),
                                (index) => SizedBox(
                                    width: 5,
                                    height: 1,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: widget.isColor == null
                                              ? Colors.white
                                              : Colors.grey.shade300),
                                    ))),
                          );
                        },
                      ),
                    )),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: widget.isColor == null
                                ? Colors.grey.shade200
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                      ),
                    )
                  ],
                ),
              ),
              /*
              * Bottom part of the orange card/ticket
              * */
              Container(
                decoration: BoxDecoration(
                    color: widget.isColor == null ? Styles.orangeColor : Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(widget.isColor == null ? 21 : 0),
                        bottomRight:
                            Radius.circular(widget.isColor == null ? 21 : 0))),
                padding: const EdgeInsets.only(
                    left: 16, top: 10, right: 16, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppColumnLayout(
                            firstText: parsedDate.toString(),
                            secondText: "Date",
                            alignment: CrossAxisAlignment.start,
                            isColor: widget.isColor),
                        AppColumnLayout(
                            firstText: widget.heure,
                            secondText: "Departure time",
                            alignment: CrossAxisAlignment.center,
                            isColor: widget.isColor),
                        AppColumnLayout(
                            firstText: firstText,
                            secondText: secondText,
                            alignment: CrossAxisAlignment.end,
                            isColor: widget.isColor),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
