import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skyhive/screens/ticket_view.dart';
import 'package:skyhive/widgets/double_text_widget.dart';

import '../utils/app_info_list.dart';
import '../utils/app_styles.dart';
import 'hotel_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';
  List<Map<String, dynamic>> filteredTickets = [];

  void searchTickets() {
    setState(() {
      filteredTickets = ticketList
          .where((ticket) =>
      ticket['from']['name']
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase()) ||
          ticket['to']['name']
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good morning",
                          style: Styles.headLineStyle3,
                        ),
                        const Gap(5),
                        Text(
                          "Book Tickets",
                          style: Styles.headLineStyle1,
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/images/logo.jpeg")),
                      ),
                    )
                  ],
                ),
                const Gap(25),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF4F6FD),
                      ),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Row(
                        children: [
                          // const Icon(FluentSystemIcons.ic_fluent_search_regular,
                          //     color: Color(0xFF526799)),
                          // const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchText = value;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: Styles.headLineStyle4
                                    .copyWith(color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          searchTickets();
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(40),
                    Text(
                      "The most booked flights",
                      style: Styles.headLineStyle1,
                      textAlign: TextAlign.left,
                    ),
              ],
            ),
          ),
          const Gap(15),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: filteredTickets.isNotEmpty
                  ? filteredTickets.map((singleTicket) => TicketView(ticket: singleTicket)).toList()
                  : ticketList.map((singleTicket) => TicketView(ticket: singleTicket)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
