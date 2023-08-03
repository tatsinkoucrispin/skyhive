import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skyhive/screens/ticket_screen.dart';
import '../utils/app_styles.dart';
import '../utils/auth_controller.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    List images = ["g.jpeg", "t.jpeg", "f.jpeg"];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: w,
                  height: h * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/color2.jpeg"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.14,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 60,
                        backgroundImage: AssetImage("assets/images/logo.jpeg"),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color(0xFFF37B67),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Color(0xFFF37B67),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(child: Container(),),
                    //     Text(
                    //       "Sign into your account",
                    //       style: TextStyle(
                    //           fontSize: 20,
                    //           color: Colors.grey[500]
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              GestureDetector(
                onTap: () {
                  AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
                  Get.toNamed('/ticket');
                },
                child: Container(
                  width: w * 0.5,
                  height: h * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF526799),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: "Have an account?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]))),
              SizedBox(height: w * 0.2),
              RichText(
                  text: TextSpan(
                text: "Sign up using one of the following methods",
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              )),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        signInWithGoogle();
                        Get.toNamed('/ticket');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[500],
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("assets/images/g.jpeg"),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     //await signInWithGoogle();
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(10.0),
                    //     child: CircleAvatar(
                    //       radius: 30,
                    //       backgroundColor: Colors.grey[500],
                    //       child: CircleAvatar(
                    //         radius: 25,
                    //         backgroundImage: AssetImage("assets/images/f.jpeg"),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        signInWithTwitter();
                        Get.toNamed('/ticket');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[500],
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("assets/images/t.jpeg"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
        apiKey: 'ujsa9QUFmNZBWve216qoaxQds',
        apiSecretKey:'FasagKV5Fd65LJK4V2THa2prorHi93HEDUOyfGF9rQU38bhTnf',
        redirectURI: 'flutter-twitter-login://'
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  }
}
