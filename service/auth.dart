import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> signInAnonymosly() async {
    final userCredential = await _firebaseAuth.signInAnonymously();

    return userCredential.user;
  }

  Future<User> createUserWithEmailPassword(
      String email, String password) async {
    UserCredential userCredentials;
    try{
      userCredentials= await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException catch(e){
      rethrow;

    }


  }

  Future<void> sendResetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Stream<User> authStatus() {
    return _firebaseAuth.authStateChanges();
  }

  Future<User> signInWithEmailPassword(String email, String password) async {
    UserCredential userCredentials;
   try {
      userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredentials.user;

    } on FirebaseAuthException catch(e){
     rethrow;
    }

  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } else {
      return null;
    }
  }

Future<DocumentSnapshot> getGonderi()async{

  CollectionReference users =  FirebaseFirestore.instance.collection('Gönderi');
  users.doc('FQJUcXlSQV3ZvwgqwQBa').get();

}


}
