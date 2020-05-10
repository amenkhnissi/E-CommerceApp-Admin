import 'package:admin_panel/models/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create Admin obj based on firebase user
  Admin _userFromFirebaseUser(FirebaseUser user) {
    return user != null ?  Admin(uid: user.uid,email: user.email) : null;
  }

  // sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  
  
  
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
