import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/intro_info.dart';
import 'package:get/utils.dart';
import 'package:todo_app/screens/login.dart';

class IntroInfoController extends GetxController {
var selectedIndex=0.obs;
var pageController = PageController();
bool get isLastPage => selectedIndex.value == intro.length-1;
forwardActon(){
  if(isLastPage){
    // go to login Page

    //TODO: if else need for signout
  Get.to(LoginPage());
  }
  else
  pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
}

  List<IntroInfo> intro = [
    IntroInfo('assets/intro3.jpg', 'Page1',
        'Lorem Ipsum is simply dummy text of the printing and type setting industry.'),
        IntroInfo('assets/intro4.jpg', 'Page2',
        'Lorem Ipsum is simply dummy text of the printing and type setting industry.'),
        IntroInfo('assets/intro3.jpg', 'Page3',
        'Lorem Ipsum is simply dummy text of the printing and type setting industry.')
  ];
}
