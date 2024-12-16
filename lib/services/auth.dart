import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_texi_tracker/model/firebase_custom_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //firebase sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  //firebase sign up
  Future registrationWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  //get firebase user
  FirebaseCustomUser? _userFromFirebase(User? user) {
    return user != null ? FirebaseCustomUser(uid: user.uid) : null;
  }

  //reset password
  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  //get stream of chatUser
  Stream<FirebaseCustomUser?> get getChatUser{
    return _auth.authStateChanges().map(_userFromFirebase);
  }

}
