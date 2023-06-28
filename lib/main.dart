import 'package:flutter/material.dart';
import 'package:skyhive/screens/bottom_bar.dart';
import 'package:skyhive/utils/app_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkyHive',
      theme: ThemeData(

          primaryColor: primary,
      ),
      home: const BottomBar(),
    );
  }
}