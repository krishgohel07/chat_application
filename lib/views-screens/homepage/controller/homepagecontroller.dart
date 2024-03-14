import 'package:chat_application/helper/firestorehelper.dart';
import 'package:chat_application/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Homepagecontroller extends GetxController {
  List<UserData> fetchedalldata = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    List<QueryDocumentSnapshot> data =
        await FirestoreHelper.firestoreHelper.fetchalluserdata();
    print("**********************************************88");
    print(data);
    for (var element in data) {
      fetchedalldata.add(UserData(
          id: element['id'],
          name: element['name'],
          email: element['email'],
          password: element['password']));
    }
    update();
  }
}
