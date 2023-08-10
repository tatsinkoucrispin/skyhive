import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          body: TicketViews(departure: "", arrival: "", heure: "", date: ""),
        ),
      ),
    );
  }
}