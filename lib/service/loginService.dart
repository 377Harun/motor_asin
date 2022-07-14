import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_asin/components/noConnectionSnackBar.dart';
import 'package:motor_asin/models/Authantication.dart';

void loginResult() {
  AuthService _auth = AuthService();
  GetStorage box = GetStorage();

  var user = _auth.signIn(box.read("email"), box.read("password"));
  user.then((value) async {
    if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
      await FirebaseFirestore.instance
          .collection("Person")
          .where('email', isEqualTo: box.read("email"))
          .get()
          .then((res) {
        if (res.docs.length > 0) {
          res.docs[0]["isAdmin"] == true
              ? box.write("admin", true)
              : box.write("admin", false);
        } else {
          box.write("admin", false);
        }
      }, onError: (e) {
        // print("Hayır admin değil.");
      });
    }
  }).onError((error, stackTrace) {
    snackBarHata();
  });
}
