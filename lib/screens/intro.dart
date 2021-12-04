import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/introInfo_controller.dart';
import 'package:todo_app/models/intro_info.dart';

class Intro extends StatelessWidget {
  final _controller = IntroInfoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.selectedIndex,
                itemCount: _controller.intro.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_controller.intro[index].ImageAsset),
                        SizedBox(height: 15,),
                        Text(_controller.intro[index].title,style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(_controller.intro[index].description,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red,),textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                    ),
                    padding: EdgeInsets.all(20)
                  );
                }),
            Positioned(
              bottom: 20,
              left: 150,
              child: Row(
                children: List.generate(_controller.intro.length,
                        (index) => Obx(() {
                            return Container(
                  margin: const EdgeInsets.all(4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _controller.selectedIndex.value==index? Colors.deepOrange:Colors.black12,
                    shape: BoxShape.circle
                  ),
                );
                          }
                        )),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: _controller.forwardActon,
                elevation: 0,
                child: Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
