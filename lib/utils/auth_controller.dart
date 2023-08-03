import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_page.dart';
import '../screens/profile_screen.dart';
import '../screens/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{
  //AuthController.instance..
  static AuthController instance = Get.find();
  //email, password, name...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user){
    if(user==null){
      print("login page");
      Get.offAll(()=>LoginPage());
    } else {
      Get.offAll(()=>ProfileScreen(email:user.email!));
    }
  }
  void register(String email, password)async{
    try{
     await auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About User", "User message",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Account creation failed",
        style: TextStyle(
            color: Colors.white
        ),
      ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white
          ),
        )
      );
    }
  }
  void login(String email, password)async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
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
            e.toString(),
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }
  }
  void logOut()async{
    await auth.signOut();
  }
}