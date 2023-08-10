import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyhive/screens/ticket_view.dart';
import 'package:skyhive/utils/app_info_list.dart';
import 'package:skyhive/widgets/column_layout.dart';
import 'package:skyhive/widgets/ticket_taps.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import '../utils/ticket_view.dart';
import '../widgets/layout_builder_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/rendering.dart';
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

class TicketScreen extends StatefulWidget {
  late final String passengerController;
  late final String valueChoose;
  late final String departure;
  late final String arrival;
  late final String date;
  late final String heure;

  TicketScreen({Key? key,
    required this.passengerController,
    required this.valueChoose,
    required this.departure,
    required this.arrival,
    required this.date,
    required this.heure})
      : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  void initState() {
    super.initState();
    initializeData();
  }
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
    final size = AppLayout.getSize(context);
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
              // Gap(AppLayout.getHeight(20)),
              //     const AppTicketTabs(firstTab: "Upcoming", secondTab: "Previous"),
              Gap(AppLayout.getHeight(20)),
              Container(
                padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                child: TicketViews(
                  isColor: true,
                  departure: widget.departure,
                  arrival: widget.arrival,
                  heure: widget.heure,
                  date: widget.date,
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
                              firstText: widget.passengerController,
                              secondText: 'Passenger',
                              alignment: CrossAxisAlignment.start,isColor: false,
                            ),
                            AppColumnLayout(
                              firstText: widget.valueChoose,
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
                  Gap(AppLayout.getHeight(20)),
                  Container(
                    padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
                child: TicketViews(
                  departure: widget.departure,
                  arrival: widget.arrival,
                  heure: widget.heure,
                  date:widget.date,
                ),
              ),
                  Gap(AppLayout.getHeight(20)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => FormScreen());
                },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: AppLayout.getWidth(18),
                        horizontal: AppLayout.getWidth(8),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF526799),
                        borderRadius: BorderRadius.circular(AppLayout.getWidth(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Editer",
                          style: Styles.textStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Gap(AppLayout.getHeight(15)),
                  GestureDetector(
                    onTap: () {
                      generatePDF();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: AppLayout.getWidth(18),
                        horizontal: AppLayout.getHeight(8),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF37B67),
                        borderRadius: BorderRadius.circular(AppLayout.getWidth(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Imprimer",
                          style: Styles.textStyle.copyWith(color: Colors.white),
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
            ])
    );
  }
  Future<void> initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.departure = prefs.getString('') ?? '';
      widget.arrival = prefs.getString('') ?? '';
      widget.date = prefs.getString('date') ?? 'date';
      widget.passengerController = prefs.getString('') ?? '';
      widget.valueChoose = prefs.getString('') ?? '';
      widget.heure = prefs.getString('') ?? '';
    });
  }
  Future<void> generatePDF() async {
    final pdf = pw.Document();
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
    pw.Widget generateTicket() {
      return pw.Center(
        child: pw.Column(
          children: [
            pw.Text(
              'Tickets',
              style: pw.TextStyle(fontSize: 20),
            ),
            pw.Container(
              padding: pw.EdgeInsets.only(left: 15),
              child: pw.Column(
                children: [
                  pw.Text(
                    'Contenu du ticket',
                    style: pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 1),
                  pw.Container(
                    color: PdfColors.white,
                    padding: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    margin: pw.EdgeInsets.symmetric(horizontal: 15),
                    child: pw.Column(
                      children: [
                        pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Passenger',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                            pw.Text(
                              'class',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 20),
                        pw.Container(
                          height: 5,
                          color: PdfColors.black,
                        ),
                        pw.SizedBox(height: 20),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'First Text',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                            pw.Text(
                              'First Texte',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 20),
                        pw.Container(
                          height: 5,
                          color: PdfColors.black,
                        ),
                        pw.SizedBox(height: 20),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                              children: [
                                pw.Row(
                                  children: [
                                    pw.Image(
                                      pw.MemoryImage(
                                        File('assets/images/visa.png').readAsBytesSync(),
                                      ),
                                      width: 40,
                                      height: 40,
                                    ),
                                    pw.Text(
                                      '*** 2462',
                                      style: pw.TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                pw.Text(
                                  'Payment method',
                                  style: pw.TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            pw.Text(
                              'Second Texte',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 20),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 1),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: const pw.BorderRadius.only(
                        bottomRight: pw.Radius.circular(21),
                        bottomLeft: pw.Radius.circular(21),
                      ),
                    ),
                    margin: const pw.EdgeInsets.only(left: 15, right: 15),
                    padding: const pw.EdgeInsets.only(top: 20, bottom: 20),
                    child: pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 15),
                      child: pw.BarcodeWidget(
                        barcode: pw.Barcode.code128(),
                        data: 'https://github.com/tatsinkoucrispin',
                        drawText: false,
                        width: double.infinity,
                        height: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    };
    pdf.addPage(
      pw.Page(
          build: (pw.Context context) => generateTicket(),
      ),
    );

    final outputDirectory = await getExternalStorageDirectory();
    final filePath = path.join(outputDirectory!.path, 'ticket.pdf');
    final output = File(filePath);
    final bytes = await pdf.save();
    await output.writeAsBytes(bytes.toList());

    print('Fichier PDF enregistré avec succès');
  }
}
