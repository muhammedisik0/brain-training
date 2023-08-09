import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/enum_constants.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signInAnonymously({required String nickname}) async {
    try {
      await _firebaseAuth.signInAnonymously();
      await user!.updateDisplayName(nickname);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          break;
        default:
          break;
      }
    }
  }

  void signOut() => _firebaseAuth.signOut();

  void deleteUser() => user!.delete();

  AuthType get authType {
    return user!.isAnonymous ? AuthType.anonymous : AuthType.google;
  }
}
