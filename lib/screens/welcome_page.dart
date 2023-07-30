import 'package:flutter/material.dart';
import 'package:skyhive/utils/auth_controller.dart';

import '../utils/app_styles.dart';

class WelcomePage extends StatelessWidget {
  String email;
   WelcomePage({super.key,required this.email});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                width: w,
                height: h*0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/color2.jpeg"
                      ),
                      fit: BoxFit.cover
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: h*0.14,),
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: 60,
                      backgroundImage: AssetImage(
                          "assets/images/logo.jpeg"
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 70,),
            Container(
              width: w,
              margin: const EdgeInsets.only(left: 20),
              child:  Column(
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 200,),
            GestureDetector(
              onTap:(){
                AuthController.instance.logOut();
              },
              child: Container(
                width: w*0.5,
                height: h*0.08,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF526799),
                ),
                child:  const Center(
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
