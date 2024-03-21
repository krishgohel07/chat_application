import 'package:chat_application/views-screens/chatpage/chatpage.dart';
import 'package:chat_application/views-screens/homepage/homepage.dart';
import 'package:chat_application/views-screens/loginscreen/loginscreen.dart';
import 'package:chat_application/views-screens/phonenumber/phonenumber.dart';
import 'package:chat_application/views-screens/splashscreen/splash-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});
  bool? islogout;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/login', page: () => Loginscreen()),
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/phonenumber', page: () => Phonenumber()),
        GetPage(name: '/chatpage', page: () => chatpage()),
      ],
    );
  }
}
