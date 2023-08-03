import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skyhive/screens/ticket_view.dart';
import 'package:skyhive/utils/app_info_list.dart';
import 'package:skyhive/widgets/column_layout.dart';
import 'package:skyhive/widgets/ticket_taps.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';
import '../widgets/layout_builder_widget.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'form_screen.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(20), vertical: AppLayout.getHeight(20)),
          children: [
            Gap(AppLayout.getHeight(40)),
            Text("Tickets",style: Styles.headLineStyle1,),
            Gap(AppLayout.getHeight(20)),
            const AppTicketTabs(firstTab: "Upcoming", secondTab: "Previous"),
            Gap(AppLayout.getHeight(20)),
            Container(
              padding: EdgeInsets.only(left: AppLayout.getHeight(15)),
              child: TicketView(ticket: ticketList[0], isColor: true),
            ),
            const SizedBox(height: 1,),

            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child:  Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppColumnLayout(
                        firstText: 'Tatsinkou',
                        secondText: 'Passenger',
                        alignment: CrossAxisAlignment.start,isColor: false,
                      ),
                      AppColumnLayout(
                        firstText: 'Bussiness',
                        secondText: 'class',
                        alignment: CrossAxisAlignment.end,isColor: false,
                      )
                    ],
                  ),
                  Gap(AppLayout.getHeight(20)),
                  const AppLayoutBuilderWidget(sections:15,isColor: false, width: 5,),
                  Gap(AppLayout.getHeight(20)),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppColumnLayout(
                        firstText: '0055 4444 77147',
                        secondText: 'Number of E-ticket',
                        alignment: CrossAxisAlignment.start,isColor: false,
                      ),
                      AppColumnLayout(
                        firstText: 'B2SG28',
                        secondText: 'Booking code',
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
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/visa.png", scale: 40,),
                              Text("*** 2462",style: Styles.headLineStyle3)
                            ],
                          ),
                          Gap(5),
                          Text("Payment method", style: Styles.headLineStyle4,)
                        ],
                      ),
                      const AppColumnLayout(
                        firstText: '\$249.99',
                        secondText: 'Price',
                        alignment: CrossAxisAlignment.end,isColor: false,
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
              child: TicketView(ticket: ticketList[0], ),
            ),
            Gap(AppLayout.getHeight(20)),
            GestureDetector(
              onTap: () {
                FormScreen();
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
}
