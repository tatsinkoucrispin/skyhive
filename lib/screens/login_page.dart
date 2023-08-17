import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skyhive/screens/bottom_bar.dart';
import 'package:skyhive/screens/profile_screen.dart';
import 'package:skyhive/screens/singup_page.dart';
import 'package:skyhive/screens/ticket_screen.dart';
import 'package:skyhive/stripe_payment/payment_manager.dart';
import '../utils/app_styles.dart';
import '../utils/auth_controller.dart';
import 'form_screen.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic>? paymentIntentData;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h*0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/color1.jpeg"
                    ),
                      fit: BoxFit.cover
                  ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Sign into your account",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[500]
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2)
                        )
                      ]
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Your email",
                          prefixIcon: const Icon(Icons.email, color: Color(0xFFF37B67),),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0
                          )
                        ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Your Password",
                          prefixIcon: const Icon(Icons.password, color: Color(0xFFF37B67),),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: Container(),),
                      Text(
                        "Sign into your account",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[500]
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 70,),
            GestureDetector(
              onTap: () async {
                if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty ){
                  AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                  await ProfileScreen(email: emailController.text,);
                  Get.to(()=> BottomBar(selectedIndex: 0,
                      departure: "",
                      arrival: "",
                      dates: "", heure: "",
                      passengerController: "",
                      valueChoose: ""), arguments:const HomeScreen());
                } else {
                  Get.snackbar("About Login", "Login message",
                      backgroundColor: Colors.redAccent,
                      snackPosition: SnackPosition.BOTTOM,
                      titleText: Text(
                        "Login failed",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      messageText: Text(
                        toString(),
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                  );
                }

              },
              child: Container(
                width: w*0.5,
                height: h*0.08,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFF37B67),
                ),
                child:Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: w*0.2),
            RichText(text: TextSpan(
              text: "Don\'t have an account?",
              style: TextStyle(
                color: Colors.grey[500], fontSize: 20),
                      children: [
                    TextSpan(
                        text: " Create",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignUpPage())),
                  ]))
            ],
          ),
        ));
  }
  // void makePayment() async {
  //   try {
  //     paymentIntentData = await createPaymentIntent();
  //     var gpay = const PaymentSheetGooglePay(
  //         merchantCountryCode: "US", currencyCode: "US", testEnv: true);
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //       paymentIntentClientSecret: paymentIntentData!['client_secret'],
  //       style: ThemeMode.dark,
  //       merchantDisplayName: 'Tatsinkou',
  //       googlePay: gpay,
  //     ));
  //     displayPaymentSheet(context);
  //   } catch (e) {
  //     print('exception' + e.toString());
  //   }
  // }
  // void displayPaymentSheet(BuildContext context) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //     print("Paid successfully");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Paid successfully")),
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         content: Text("Cancelled"),
  //       ),
  //     );
  //   }
  // }
  // createPaymentIntent() async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "amount": "1000",
  //       "currency": "USD",
  //     };
  //     http.Response response = await http.post(
  //         Uri.parse("https://api.stripe.com/v1/payment_intents"),
  //         body: body,
  //         headers: {
  //           "Authorization":
  //               "Bearer sk_test_51Nc3HLC1jv8DywGjwjesmlu1aCsQ1TTUJzX3T6eRzhGftNXLb105HpBoPbUNXOVHOKQIWOm5nHs1atSVYno8T45y00g60LYwc0",
  //           "Content-Type": "application/x-www-form-urlencoded",
  //         });
  //     return json.decode(response.body);
  //   }catch(e){
  //     throw Exception(e.toString());
  //   }
  // }
}
