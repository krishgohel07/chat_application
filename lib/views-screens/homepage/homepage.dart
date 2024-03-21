import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firestorehelper.dart';
import 'package:chat_application/utils/colors.dart';
import 'package:chat_application/views-screens/homepage/controller/homepagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Homepagecontroller homepagecontroller = Get.put(Homepagecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [appPrimarybluecolor, appPrimarywhitecolor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: GetBuilder<Homepagecontroller>(
            builder: (controller) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actions: [
                      IconButton(
                          onPressed: () async {
                            Get.offAllNamed('login');
                          },
                          icon: Icon(Icons.exit_to_app))
                    ],
                    backgroundColor: Colors.transparent,
                    title: Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 25,
                        //   backgroundImage: NetworkImage(
                        //       (Authcontroller.currentuser!.photoURL == null)
                        //           ?
                        //           : Authcontroller.currentuser!.photoURL!),
                        // ),
                        const SizedBox(width: 30),
                        Text(
                            "${Authcontroller.currentuser!.email!.split("@")[0].capitalizeFirst}"),
                      ],
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          homepagecontroller.fetchedalldata
                              .map((e) => Card(
                                    child: ListTile(
                                      onTap: () async {
                                        await FirestoreHelper.firestoreHelper
                                            .createChatRoomId(
                                          Authcontroller.currentuser!.email!,
                                          e.email,
                                        );
                                        Get.toNamed('chatpage', arguments: e);
                                      },
                                      title: Text(e.name),
                                      subtitle: Text(e.email),
                                    ),
                                  ))
                              .toList()))
                ],
              );
            },
          )),
    );
  }
}
