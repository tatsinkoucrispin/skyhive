import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skyhive/screens/ticket_view.dart';
import '../utils/app_info_list.dart';
import '../utils/app_styles.dart';
import '../utils/ticket_view.dart';
import 'form_screen.dart';
import 'increment.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int incrementCount = 0;
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
              .contains(searchText.toLowerCase()) ||
          ticket['date']
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
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
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: filteredTickets.isNotEmpty
                      ? filteredTickets.length
                      : ticketList.length,
                  itemBuilder: (context, index) {
                    final singleTicket = filteredTickets.isNotEmpty
                        ? filteredTickets[index]
                        : ticketList[index];
                    return Column(
                      children: [
                        TicketView(ticket: singleTicket),
                        SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}