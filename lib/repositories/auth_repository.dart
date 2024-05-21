
import 'package:firebase_auth/firebase_auth.dart';



class AuthRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password)async{
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Giriş Başarılı";
    } 
    
    
    
    catch (error) {
      return error.toString();
    }
  }


  Future<String?> signUp(String email, String password)async{
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
}