import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/helper/firestorehelper.dart';
import 'package:chat_application/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? Verificationid;

  Future<String?> signupuserwithemailandpassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print("step1");
      UserData userData = UserData(
          id: userCredential.user!.uid,
          name: "${email.split("@")[0].capitalizeFirst}",
          email: email,
          password: password);
      print("step2");
      await FirestoreHelper.firestoreHelper
          .addusertoFireStoreDatabase(userData);
      print("all step done");
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  loginUserwithemailandpassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      Authcontroller.currentuser = userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<User?> signinwithgoogle() async {
    final GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? signInAuthentication =
        await signInAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: signInAuthentication?.accessToken,
        idToken: signInAuthentication?.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    Authcontroller.currentuser = userCredential.user;

    return userCredential.user;
  }

  loginwithphonenumber(String number) {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91$number",
        verificationCompleted: (e) {
          print('===================');
          print(e);
          print('===================');
        },
        verificationFailed: (e) {
          print('-----------------------');
          print(e);
          print('-----------------------');
        },
        codeSent: (String verificationid, int? token) {
          Verificationid = verificationid;
        },
        codeAutoRetrievalTimeout: (e) {
          print('*****************');
          print(e);
          print('*****************');
        });
  }
}
