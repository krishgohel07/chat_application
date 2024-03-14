import 'package:chat_application/helper/auth_helper.dart';
import 'package:chat_application/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class Phonenumber extends StatelessWidget {
  Phonenumber({super.key});

  TextEditingController phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, appPrimarybluecolor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                margin: EdgeInsets.only(left: 50, right: 50, top: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Color(0xffE9E2F1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 50),
                      child: TextField(
                        controller: phonenumber,
                        decoration: InputDecoration(
                          fillColor: Color(0xffDDD5E8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          hintText: 'Enter Phone number',
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 50, right: 70, left: 70),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                          border: Border.all(color: appPrimarywhitecolor),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(5.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 5)
                          ]),
                      child: Center(
                        child: InkWell(
                          onTap: () async{
                            await AuthHelper.authHelper.loginwithphonenumber(phonenumber.text);
                            Get.toNamed('otp');
                          },
                          child: Text("Get OTP"),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
            //
          )),
    );
  }
}
