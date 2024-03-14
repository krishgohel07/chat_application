import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/auth_helper.dart';
import 'package:chat_application/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  Duration logintime = const Duration(milliseconds: 2250);
  Authcontroller authcontroller = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterLogin(
            logo: 'assets/chat-bubbles.png',
            title: 'Chat',
            hideForgotPasswordButton: true,
            loginAfterSignUp: false,
            theme: LoginTheme(
                pageColorDark: appPrimarywhitecolor,
                pageColorLight: appPrimarybluecolor),
            onLogin: (LoginData loginData) async {
              return await AuthHelper.authHelper.loginUserwithemailandpassword(
                  email: loginData.name, password: loginData.password);
            },
            onSignup: (SignupData signupData) async {
              return await AuthHelper.authHelper.signupuserwithemailandpassword(
                  email: signupData.name!, password: signupData.password!);
            },
            onSubmitAnimationCompleted: () {
              if (Authcontroller.currentuser != null) {
                Get.offAndToNamed('/');
              }
            },
            loginProviders: [
              LoginProvider(
                  button: Buttons.google,
                  label: 'Google',
                  animated: true,
                  callback: () async {
                    Future.delayed(logintime);
                    await AuthHelper.authHelper
                        .signinwithgoogle()
                        .then((value) {
                      Get.offAllNamed('/');
                    });
                    return null;
                  }),
              // LoginProvider(
              //   button: Buttons.anonymous,
              //   label: 'Phone',
              //   animated: true,
              //   callback: () {
              //     Future.delayed(logintime);
              //     Get.toNamed('phonenumber');
              //   },
              // )
            ],
            onRecoverPassword: (_) {}));
  }
}
