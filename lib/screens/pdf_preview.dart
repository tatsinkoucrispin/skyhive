import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skyhive/screens/ticket_view.dart';
import 'package:skyhive/utils/app_info_list.dart';
import 'package:skyhive/widgets/column_layout.dart';
import 'package:skyhive/widgets/ticket_taps.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import '../utils/ticket_view.dart';
import '../widgets/layout_builder_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'dart:math';
import 'form_screen.dart';
import 'imprim_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skyhive/screens/ticket_view.dart';
import 'package:skyhive/utils/app_info_list.dart';
import 'package:skyhive/widgets/column_layout.dart';
import 'package:skyhive/widgets/ticket_taps.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'dart:typed_data';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import '../utils/ticket_view.dart';
import '../widgets/layout_builder_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'dart:math';
import 'form_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class PDFPreviewScreen extends StatelessWidget {
  final String pdfPath;

  PDFPreviewScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    String generateRandomNumber() {
      Random random = Random();
      String number = '';

      for (int i = 0; i < 12; i++) {
        int digit = random.nextInt(10);
        number += digit.toString();

        if ([3, 7].contains(i)) {
          number += ' ';
        }
      }
      return number;
    }
    String generateRandomString() {
      Random random = Random();
      const int startAscii = 65; // ASCII pour 'A'
      const int endAscii = 90; // ASCII pour 'Z'
      String generatedString = '';

      for (int i = 0; i < 6; i++) {
        int randomAscii =
            random.nextInt(endAscii - startAscii + 1) + startAscii;
        String randomChar = String.fromCharCode(randomAscii);
        generatedString += randomChar;
      }

      return generatedString;
    }
    String generateRandomPrice(String label) {
      Random random = Random();
      String price = '\$';

      if (label.contains('Economic')) {
        price += '1000';
      } else if (label.contains('Business')) {
        price += '3500';
      } else if (label.contains('Premiere')) {
        price += '10000';
      } else {
        double randomPrice =
            (random.nextDouble() * (10000 - 100) + 100).floorToDouble() / 100;
        price += randomPrice.toStringAsFixed(2);
      }

      return price;
    }
    String label = 'Economic';
    String firstTexts = generateRandomPrice(label);
    String secondTexts = 'Price';
    String firstTexte = generateRandomString();
    String secondTexte = 'Booking code';
    String firstText = generateRandomNumber();
    String secondText = 'Number of E-ticket';
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: Stack(children: [
          ListView(
            padding: EdgeInsets.symmetric(
                horizontal: AppLayout.getHeight(20),
                vertical: AppLayout.getHeight(20)),
            children: [
              Gap(AppLayout.getHeight(40)),
              Text(
                "Tickets",
                style: Styles.headLineStyle1,
              ),
              Gap(AppLayout.getHeight(20)),
              Container(
                padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                child: TicketViews(
                  isColor: true,
                  departure: '',
                  arrival: '',
                  heure: '',
                  dates: '',
                ),
              ),
              const SizedBox(height: 1,),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppColumnLayout(
                          firstText: '45',
                          secondText: 'Passenger',
                          alignment: CrossAxisAlignment.start,isColor: false,
                        ),
                        AppColumnLayout(
                          firstText: "valueChoose",
                          secondText: 'class',
                          alignment: CrossAxisAlignment.end,isColor: false,
                        )
                      ],
                    ),
                    Gap(AppLayout.getHeight(20)),
                    const AppLayoutBuilderWidget(sections:15,isColor: false, width: 5,),
                    Gap(AppLayout.getHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppColumnLayout(
                          firstText: firstText,
                          secondText: secondText,
                          alignment: CrossAxisAlignment.start,
                          isColor: false,
                        ),
                        AppColumnLayout(
                          firstText: firstTexte,
                          secondText: secondTexte,
                          alignment: CrossAxisAlignment.end,
                          isColor: false,
                        )
                      ],
                    ),
                    Gap(AppLayout.getHeight(20)),
                    const AppLayoutBuilderWidget(sections:15,isColor: false, width: 5,),
                    Gap(AppLayout.getHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/visa.png",
                                  scale: 40,
                                ),
                                Text("*** 2462", style: Styles.headLineStyle3)
                              ],
                            ),
                            Gap(5),
                            Text(
                              "Payment method",
                              style: Styles.headLineStyle4,
                            )
                          ],
                        ),
                        AppColumnLayout(
                          firstText: firstTexts,
                          secondText: secondTexts,
                          alignment: CrossAxisAlignment.end,
                          isColor: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 1,),
                    Gap(AppLayout.getHeight(20)),
                  ],
                ),
              ),
              /*
            bar code
             */
              const SizedBox(height: 1,),
              Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(AppLayout.getHeight(21)),
                        bottomLeft: Radius.circular(AppLayout.getHeight(21))
                    )
                ),
                margin: EdgeInsets.only(left: AppLayout.getHeight(15),right: AppLayout.getHeight(15)),
                padding: EdgeInsets.only(top: AppLayout.getHeight(20), bottom: AppLayout.getHeight(20)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppLayout.getHeight(15)),
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: 'https://github.com/tatsinkoucrispin',
                      drawText: false,
                      color: Styles.textColor,
                      width: double.infinity,
                      height: 70,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: AppLayout.getHeight(22),
            top: AppLayout.getHeight(295),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Styles.textColor, width: 2)
              ),
              child: CircleAvatar(
                maxRadius: 4,
                backgroundColor: Styles.textColor,
              ),
            ),
          ),
          Positioned(
            right: AppLayout.getHeight(22),
            top: AppLayout.getHeight(295),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Styles.textColor, width: 2)
              ),
              child: CircleAvatar(
                maxRadius: 4,
                backgroundColor: Styles.textColor,
              ),
            ),
          ),
        ]),
    //   body: PDFView(
    //   filePath: pdfPath,
    // ),
    );
  }
}
