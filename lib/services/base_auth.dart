import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<User?> getCurrentUser();
}

class Auth implements BaseAuth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    User? user = firebaseAuth.currentUser;
    return user!;
  }
}
