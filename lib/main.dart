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
import 'package:skyhive/stripe_payment/stripe_keys.dart';
import 'package:skyhive/utils/app_styles.dart';
import 'package:skyhive/utils/auth_controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  //
  initializeDateFormatting('en_US', null).then((_){
    Stripe.publishableKey = ApiKeys.publishableKey;
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
            return MaterialPageRoute(builder: (_) =>  BottomBar(
                selectedIndex: 0,
                departure:'',
                arrival:'',
                dates:'',
                heure:'',
                passengerController:'',
                valueChoose:''));
          case '/form':
            return MaterialPageRoute(builder: (_) => const FormScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },
    );
  }
}