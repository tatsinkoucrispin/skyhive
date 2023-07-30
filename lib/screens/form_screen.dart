import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../utils/app_styles.dart';
import 'dart:convert';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String valueChoose = "Premiere";
  List<String> listItem = ["Premiere", "Business", "Economic"];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController departureController = TextEditingController();
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body:  Center(
        child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo.jpeg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "Departure",
                  hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "Arrival",
                  hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "name",
                  hintStyle: Styles.textStyle.copyWith(color: Colors.grey),
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  hintText: "Passeport",
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF526799),width: 1.5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButton(
                  hint: const Text("Select Class:"),
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.grey.shade300,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19
                  ),
                  iconSize: 30,
                  isExpanded: true,
                  underline: SizedBox(),
                  value: valueChoose,
                  onChanged: (newValue){
                    setState(() {
                      valueChoose = newValue.toString();
                    });
                  },
                  items: listItem.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                enabled: false, // désactiver le champ
                decoration: InputDecoration(
                  hintText: "Price",
                  //prefixIcon: Icon(icons),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  // définir la couleur de fond et de texte pour le champ désactivé
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: ()async {
                    makePayment();
                  // if (_formkey.currentState!.validate()) {
                  //   await makePayment();
                  // } else {
                  //   await makePayment();
                  // }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF526799),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),

                  ),
                ),
                child: Text(
                  "Pay ticket",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ))),
      ),
    );
  }
  void makePayment()async{
    try{
      paymentIntentData = await createPaymentIntent('20','USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Tatsinkou'
          )
      );
      displayPaymentSheet();
    }catch(e){
      print('exception'+e.toString());
    }
  }
  displayPaymentSheet() async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value) => {
        //success State
        print("Payement Succesful")
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Paid succesfully")));
    } on StripeError catch (e){
      print(e.toString());
      showDialog(context: context, builder: (_) => AlertDialog(
        content: Text("Cancelled"),
      ));
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
