import 'package:companionapp_mh/services/database.dart';
import 'package:flutter/material.dart';
import 'package:companionapp_mh/models/auser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on User
  Auser? _userFromUser(User? user) {
    return user != null ? Auser(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<Auser?> get user {
    return _auth.authStateChanges().map(_userFromUser);
  }

  // Sign in anonymously
  Future<Auser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInwithEandP(String email,String password) async{
    try{
      UserCredential res=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user=res.user!;
      return _userFromUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  // Register with email and password
  Future registerwithEandP(String email,String password) async{
    try{
      UserCredential res=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user=res.user!;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('happy', 'new user', 'not defined', 0);
      return _userFromUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}
