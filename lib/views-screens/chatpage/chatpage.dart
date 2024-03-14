import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firestorehelper.dart';
import 'package:chat_application/model/usermodel.dart';
import 'package:flutter/material.dart';

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserData userData = ModalRoute.of(context)!.settings!.arguments as UserData;
    return Scaffold(
      appBar: AppBar(
        title: Text(userData.name),
        elevation: 3,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: Container(),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        //hintText: "Enter message",
                        isDense: false,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: FloatingActionButton(
                      onPressed: () async {
                        await FirestoreHelper.firestoreHelper
                            .sendmessage(Authcontroller.currentuser!.email!,
                            userData.email, message.text)
                            .then((value) {
                          message.clear();
                        });
                      },
                      elevation: 0,
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
