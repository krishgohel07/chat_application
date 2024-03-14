import 'dart:async';

import 'package:chat_application/views-screens/homepage/controller/homepagecontroller.dart';
import 'package:get/get.dart';

class Splashcontroller extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer(Duration(seconds: 3), () {
      Get.offAndToNamed('login');
    });
  }
}
