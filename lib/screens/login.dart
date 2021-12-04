import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  var pageController = PageController();
   AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
      child: FloatingActionButton.extended(
          onPressed: ()async{
          await  _authController.signInwithGoogle();
          },
        icon: SvgPicture.asset('assets/google.svg',height: 32,width: 32),
        label: Text('Sign in with google'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      ),
    );
  }
}

