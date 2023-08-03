import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skyhive/screens/singup_page.dart';
import 'package:get/get.dart';
import 'package:skyhive/screens/ticket_screen.dart';
import '../utils/app_styles.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/auth_controller.dart';

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
              onTap: ()async{
                AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                await makePayment();
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
                color: Colors.grey[500],
                fontSize: 20
              ),
              children:  [
                TextSpan(
                text: " Create",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
                ),
              ]
            )
            )
          ],
        ),
      )
    );
  }
  Future<void> makePayment()async{
    try{
      paymentIntentData = await createPaymentIntent('20','USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Tatsinkou'
          )
      );
      displayPaymentSheet(context);
    }catch(e){
      print('exception'+e.toString());
    }
  }
  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        // success state
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => TicketScreen()),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Paid successfully")));
    } on StripeError catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    }
  }
  createPaymentIntent(String amount, String currency)async{
    try{
      Map<String , dynamic> body ={
        'amount': calculateAmount(amount),
        'currency':currency,
        'payment_method_types[]':'card'
      };
      http.Response response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':'Bearer sk_test_51NOxOLKaCctTIWKDVn2EgDxpUtPJK329qf8EvzlFGWuX54oS0ttpGpO0pSBk472r8bOFqeAaBPiacSaAkvxVweGd00yKZ8EIrw',
            'Content-Type': 'application/x-www-form-urlencoded',
          });
      return json.decode(response.body.toString());
    }catch(e){
      print('exception'+e.toString());
    }
  }
  calculateAmount(String amount){
    final price = int.parse(amount)*100;
    return price.toString() ;
  }
}
