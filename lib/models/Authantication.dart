import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(String name, String email, String password) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (_auth.currentUser?.emailVerified == false) {
      await user.user?.sendEmailVerification();
    }
  }
}
