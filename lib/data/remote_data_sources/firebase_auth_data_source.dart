part of '../_data.dart';

class FirebaseAuthDataSource implements RemoteDataSource {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuthDataSource();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }
}