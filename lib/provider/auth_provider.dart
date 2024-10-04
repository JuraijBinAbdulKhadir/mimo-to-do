import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  User? _user;
  User? get user => _user;

  // Sign In method
  Future<bool> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = result.user;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false; // Return false if login fails
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Sign Up method
  Future signUp(String email, String password) async {
    isLoading =true;
    notifyListeners();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = result.user;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }

  // Sign Out method
  Future signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    isLoading = true;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: email);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
