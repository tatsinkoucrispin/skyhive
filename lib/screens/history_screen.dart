import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:skyhive/screens/ticket_view.dart';

import '../utils/app_info_list.dart';
import '../utils/app_styles.dart';
import '../utils/ticket_view.dart';
import 'increment.dart';

class HistoryScreen extends StatefulWidget {
  String departure;
  String arrival;
  String heure;
  String dates;

  HistoryScreen({Key? key,
    required this.departure,
    required this.arrival,
    required this.heure,
    required this.dates}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int incrementCount = 0;
  String searchText = '';
  List<Map<String, dynamic>> filteredTickets = [];

  void searchTickets() {
    setState(() {
      filteredTickets = ticketList.where((ticket) {
        final String fromName = ticket['from']['name'].toString().toLowerCase();
        final String toName = ticket['to']['name'].toString().toLowerCase();
        final String ticketDate = ticket['date'].toString().toLowerCase();

        bool matchesDeparture = widget.departure != null
            ? fromName.contains(widget.departure.toLowerCase())
            : true;
        bool matchesArrival = widget.arrival != null
            ? toName.contains(widget.arrival.toLowerCase())
            : true;
        bool matchesHeure = widget.heure != null
            ? ticket['heure']
                .toString()
                .toLowerCase()
                .contains(widget.heure.toLowerCase())
            : true;
        bool matchesDates = widget.dates != null
            ? ticketDate.contains(widget.dates.toLowerCase())
            : true;

        return matchesDeparture ||
            matchesArrival ||
            matchesHeure ||
            matchesDates;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<IncrementModel>(
            create: (_) => IncrementModel(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('History'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
          SingleChildScrollView(
          child: Column(
          children: [
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
          SizedBox(height: 10),
          TicketViews(
            arrival: widget.arrival,
            departure: widget.departure,
            dates: widget.dates,
            heure: widget.heure,
          ),
          // Expanded(
          //   child: ListView.builder(
          //     physics: const BouncingScrollPhysics(),
          //     padding: const EdgeInsets.only(left: 20),
          //     itemCount: filteredTickets.isNotEmpty
          //         ? filteredTickets.length + 1
          //         : ticketList.length + 1,
          //     itemBuilder: (context, index) {
          //       if (index == 0) {
          //         return SizedBox(
          //           width: double.infinity,
          //           child: TicketViews(
          //             arrival: widget.arrival,
          //             departure: widget.departure,
          //             dates: widget.dates,
          //             heure: widget.heure,
          //           ),
          //         );
          //       }
          //       // } else {
          //       //   final singleTicket = filteredTickets.isNotEmpty
          //       //       ? filteredTickets[index - 1]
          //       //       : ticketList[index - 1];
          //       //   return Column(
          //       //     children: [
          //       //       TicketView(ticket: singleTicket),
          //       //       SizedBox(height: 8),
          //       //     ],
          //       //   );
          //       // }
          //     },
          //   ),
          // ),
          ],
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
}