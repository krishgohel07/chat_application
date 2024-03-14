import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/model/fetchchatsid.dart';
import 'package:chat_application/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final FirestoreHelper firestoreHelper = FirestoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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

  void createchatroomid(String u1, String u2) async {
    List<FetchChatuserId> fetcheduserid = [];
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('chats').get();
    List<QueryDocumentSnapshot> data = querySnapshot.docs;
    if (data.isEmpty) {
      Authcontroller.chatroomid = "${u1}_$u2";
      await firebaseFirestore
          .collection('chats')
          .doc(Authcontroller.chatroomid)
          .set({'chat_id':Authcontroller.chatroomid});
      print(Authcontroller.chatroomid);

    } else {
      fetcheduserid = data.map((e) {
        String fetchuser1 = e['chat_id'].toString().split("_")[0];
        String fetchuser2 = e['chat_id'].toString().split("_")[1];
        print(fetchuser1);
        print(fetchuser2);
        return FetchChatuserId(user1: fetchuser1, user2: fetchuser2);
      }).toList();
      bool alreadyId = false;
      for (var element in fetcheduserid) {
        print("++++++++222222222222");
        alreadyId = alreadyexist(u1, u2, element);
        if (alreadyId==true) {
          print(alreadyId);
          print("otoioinhoihnroihnrohnroihnroihnroihnrtho");
          break;
        }
      }
      if (alreadyId == false) {
        Authcontroller.chatroomid="${u1}_$u2";
        print("+++++++++++++++++++++++++++++++");
        print(Authcontroller.chatroomid);
        await firebaseFirestore
            .collection('chats')
            .doc(Authcontroller.chatroomid)
            .set({
          'chat_id':Authcontroller.chatroomid
            });
        print(Authcontroller.chatroomid);
      }
    }
  }

  bool alreadyexist(String u1, String u2, FetchChatuserId element) {
    if (u1 == element.user1 || u1 == element.user2 &&
        u2 == element.user1 || u2 == element.user2) {
      if (u1 == element.user1 && u2 == element.user2) {
        print("3333333333333333333333333333333333");
        Authcontroller.chatroomid = "${u1}_$u2";
      } else {
        print("444444444444444444444444444444444444444444");
        Authcontroller.chatroomid = "${u2}_$u1";
      }
      print("${u1}_${u2}");
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
      'message': message,
      'time': DateTime.now()
    });
  }
}
