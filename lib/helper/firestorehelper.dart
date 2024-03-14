import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/model/fetchchatsid.dart';
import 'package:chat_application/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final FirestoreHelper firestoreHelper = FirestoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? imageUrl;

  Future<void> addusertoFireStoreDatabase(UserData userData) async {
    print("function called");
    await firebaseFirestore.collection('users').doc().set({
      'id': userData.id,
      'name': userData.name,
      'email': userData.email,
      'password': userData.password
    });
    print("function executed");
  }

  Future<List<QueryDocumentSnapshot>> fetchalluserdata() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('users')
        .where("email", isNotEqualTo: Authcontroller.currentuser!.email!)
        .get();
    List<QueryDocumentSnapshot> data = querySnapshot.docs;
    print("--------------------------------");
    print(data);
    return data;
  }


  Future<void> createChatRoomId(String u1, String u2) async {
    List<FetchChatuserId> fetchedChatsId = [];
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection('chats').get();

    List<QueryDocumentSnapshot> data = querySnapshot.docs;

    if (data.isEmpty) {
      Authcontroller.chatroomid = "${u1}_$u2";
      await firebaseFirestore
          .collection('chats')
          .doc(Authcontroller.chatroomid)
          .set({
        'chat_id': Authcontroller.chatroomid,
      });
      print(Authcontroller.chatroomid);
      print("====================");
    } else {
      fetchedChatsId = data.map((e) {
        String fetchUser1 = e['chat_id'].toString().split("_")[0];
        String fetchUser2 = e['chat_id'].toString().split("_")[1];
        return FetchChatuserId(user1: fetchUser1, user2: fetchUser2);
      }).toList();

      for (var e in fetchedChatsId) {
        print("u1 = ${e.user1}");
        print("u2 = ${e.user2}");
      }
      bool? alreadyId = false;
      for (var element in fetchedChatsId) {
        alreadyId = alreadyIdExists(u1, u2, element);
        if (alreadyId) {
          break;
        }
      }
      if (alreadyId == false) {
        Authcontroller.chatroomid = "${u1}_$u2";
        await firebaseFirestore
            .collection('chats')
            .doc(Authcontroller.chatroomid)
            .set({
          'chat_id': Authcontroller.chatroomid,
        });
        print(Authcontroller.chatroomid);
        print("----------_____________");
      }
    }
  }


  bool alreadyIdExists(String u1, String u2, FetchChatuserId element) {
    if ((u1 == element.user1 || u1 == element.user2) &&
        (u2 == element.user1 || u2 == element.user2)) {
      if (u1 == element.user1 && u2 == element.user2) {
        Authcontroller.chatroomid = "${u1}_$u2";
        print(Authcontroller.chatroomid);
        print("++++++++++++++++++++++++");
      } else {
        Authcontroller.chatroomid = "${u2}_$u1";
        print(Authcontroller.chatroomid);
        print("-------------////////////");
      }
      return true;
    }
    return false;
  }

  Future<void> sendmessage(
      String sender, String reciever, String message) async {
    firebaseFirestore
        .collection('chats')
        .doc(Authcontroller.chatroomid)
        .collection('message')
        .doc()
        .set({
      'sender': sender,
      'reciever': reciever,
      'type': (imageUrl != null) ? 'img' : 'text',
      'message': message,
      'time': DateTime.now()
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return firebaseFirestore
        .collection('chats')
        .doc(Authcontroller.chatroomid)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots();
  }

}
