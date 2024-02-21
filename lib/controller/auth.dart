
import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  // Current User
  Future<User?> currentUserData() async {
    return _firebaseAuth.currentUser;
  }
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> mailAndPassSignIn({required String mail, required String pwd}) async {

      await _firebaseAuth.signInWithEmailAndPassword(email: mail, password: pwd);
  }

  Future<void> createUserWithMailAndPass({required String mail, required String pwd}) async {
      await _firebaseAuth.createUserWithEmailAndPassword(email: mail, password: pwd);

  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}