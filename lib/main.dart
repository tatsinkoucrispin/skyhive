import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skyhive/screens/bottom_bar.dart';
import 'package:skyhive/screens/form_screen.dart';
import 'package:skyhive/screens/home_screen.dart';
import 'package:skyhive/screens/login_page.dart';
import 'package:skyhive/screens/search_screen.dart';
import 'package:skyhive/screens/ticket_screen.dart';
import 'package:skyhive/utils/app_styles.dart';
import 'package:skyhive/utils/auth_controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  //
  initializeDateFormatting('en_US', null).then((_){
    Stripe.publishableKey = 'pk_test_51Nc3HLC1jv8DywGjFkVhB1N862aOBWmRn12t9HxjZBUqYTJP0xNQv91q9Tcz0cNRuwJ11Z8S2a7pLiJSxxI95P4U00fl08pKEZ';
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkyHive',
      theme: ThemeData(

          primaryColor: primary,
      ),
      initialRoute: '/bottom',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/bottom':
            return MaterialPageRoute(builder: (_) => const BottomBar());
          case '/form':
            return MaterialPageRoute(builder: (_) => const FormScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/ticket':
            return MaterialPageRoute(
                builder: (_) => TicketScreen(
                    passengerController: '',
                    valueChoose: '',
                    departure: '',
                    arrival: '',
                    date: '',
                    heure: ''));
        }
      },
    );
  }
}