import 'package:chat_application/controller/splash_controller.dart';
import 'package:chat_application/views-screens/homepage/controller/homepagecontroller.dart';
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
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/chat-bubbles.png"))),
        ),
      ),
    );
  }
}
