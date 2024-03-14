import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firestorehelper.dart';
import 'package:chat_application/model/getmessagedata.dart';
import 'package:chat_application/model/usermodel.dart';
import 'package:flutter/material.dart';

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  ScrollController scrollController = ScrollController();

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserData userData = ModalRoute.of(context)!.settings!.arguments as UserData;
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(userData.name),
        elevation: 3,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream: FirestoreHelper.firestoreHelper.getMessages(),
          builder: (context, snapshot) {
            List<GetMessageData> fetchData = [];

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 12,
                        child: Center(child: Text("Say Hello 🖐")),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: TextField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  hintText: "Enter message",
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: FloatingActionButton(
                                onPressed: () async {
                                  await FirestoreHelper.firestoreHelper
                                      .sendmessage(
                                      Authcontroller.currentuser!.email!,
                                      userData.email,
                                      messageController.text)
                                      .then((value) {
                                    messageController.clear();
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
                );
              } else {
                fetchData = snapshot.data!.docs
                    .map((e) => GetMessageData(
                    message: e['message'],
                    time: e['time'],
                    sender: e['sender'],
                    type: e['type']))
                    .toList();
                return Column(
                  children: [
                    Expanded(
                      flex: 12,
                      child: ListView(
                        controller: scrollController,
                        children: fetchData
                            .map(
                              (e) => Row(
                            mainAxisAlignment: (e.sender ==
                                Authcontroller.currentuser!.email)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: (e.type == "img")
                                    ? Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(e.message),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    : Chip(
                                  label: Column(
                                    crossAxisAlignment: (e.sender ==
                                        Authcontroller
                                            .currentuser!.email)
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.message,
                                        style: const TextStyle(
                                            fontSize: 18),
                                      ),
                                      Text(
                                        '${e.time.toDate().hour}:${e.time.toDate().minute}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                hintText: "Enter message",
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: FloatingActionButton(
                              onPressed: () async {
                                await FirestoreHelper.firestoreHelper
                                    .sendmessage(
                                    Authcontroller.currentuser!.email!,
                                    userData.email,
                                    messageController.text)
                                    .then((value) {
                                  messageController.clear();
                                });

                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeOut);
                              },
                              elevation: 0,
                              child: const Icon(Icons.send),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
