import 'package:chat_application/controller/splash_controller.dart';
import 'package:chat_application/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Splashcontroller splashcontroller = Get.put(Splashcontroller());
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [appPrimarybluecolor, appPrimarywhitecolor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/chat-bubbles.png"))),
              ),
            )),
      ),
    );
  }
}
