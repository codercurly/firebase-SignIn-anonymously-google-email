import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Auth {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<User?> SignInAnonymously() async{
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user;
  }
  Future<User?> CreateUser(String email, String pass)async {

    UserCredential? usercredentials;
    try{
     usercredentials = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);}
    on FirebaseAuthException catch (e){
      print(e.message);
      rethrow;
    }
    finally{
  return usercredentials?.user;}

  }
  Future<User?> SignInEmailpass(String email, String pass)async {
    final usercredentials = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
    return usercredentials.user;
  }
  Future<void> PassReset(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential? userCredential =
      await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } else {
      return null;
    }
  }

Future<void> SignOut() async{
await _firebaseAuth.signOut();
await GoogleSignIn().signOut();

}
Stream<User?> authStatus(){
   return _firebaseAuth.authStateChanges();
  }

}