import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skyhive/screens/bottom_bar.dart';
import 'package:skyhive/screens/form_screen.dart';
import 'package:skyhive/screens/login_page.dart';
import 'package:skyhive/utils/app_styles.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:skyhive/utils/auth_controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  Stripe.publishableKey = 'pk_test_51NOxOLKaCctTIWKDXJbWi0zdnVs1POVOYCdHuGMbbXGZtV8NuncmGNly7QdwSrJ4avg7u6FkC92IvDqBVlZwv7V100VlGKxfkw';
  runApp(const MyApp());
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
      initialRoute: '/bottom-bar',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/bottom-bar':
            return MaterialPageRoute(builder: (_) => const BottomBar());
          case '/form':
            return MaterialPageRoute(builder: (_) => const FormScreen());
          // case '/login':
          //   return MaterialPageRoute(builder: (_) => const LoginPage());
        }
      },
    );
  }
}