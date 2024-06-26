import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Giriş Başarılı";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Kayıt Başarılı";
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Kayıt Başarılı";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> registerWithNames(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName('$firstName $lastName');
      }

      return "Kayıt Başarılı";
    } catch (error) {
      return error.toString();
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      print('Hata $e');
      return false;
    }
  }

  Future<void> saveUserInfoToFirestore(User user, String name, String email, String userType) async {
  try {
    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'userType': userType,
    });
  } catch (e) {
    print('Hata: $e');
  }
}
}
