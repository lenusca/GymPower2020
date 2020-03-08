import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/database.dart';

class AuthService {
  int count = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon, não quero esta
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // ligação a firebase, como quer fazer o sign in
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // guardar na base de dados
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //sign in with Google
  Future signInWithGoogle() async{
    try {
      //ligação com a base dados, forma de fazer login
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      print(_googleSignIn.currentUser.email);
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
      AuthResult result = await _auth.signInWithCredential(credential);
      // guardar na base de dados
      FirebaseUser user = result.user;
      // criar novo documento para o utilzador com aquele uid

      await DatabaseService(uid: user.uid).updateUserData(count+1, "User_icon_BLACK-01.png", user.displayName, user.email, "F", "123456", 963853790, DateTime.now());
      return _userFromFirebaseUser(user);

    } catch (error) {
      print(error.toString());
      return null;
    }

  }

  //sign in with Facebook
  Future signInWithFacebook() async{
    try {
      //ligação com a base dados, forma de fazer login
      FacebookLogin facebookLogin = FacebookLogin();
      FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email']);
      switch(facebookLoginResult.status){
        case FacebookLoginStatus.cancelledByUser:
          print("CANCELLED");
          break;
        case FacebookLoginStatus.loggedIn:
          print("LOGGED IN");
          AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: facebookLoginResult.accessToken.token);
          AuthResult result = await _auth.signInWithCredential(credential);
          // guardar na base de dados
          FirebaseUser user = result.user;
          // criar novo documento para o utilzador com aquele uid
          await DatabaseService(uid: user.uid).updateUserData(count+1, "User_icon_BLACK-01.png", user.displayName, user.email, "F", "123456", 963853790, DateTime.now());
          return _userFromFirebaseUser(user);
          break;
        case FacebookLoginStatus.error:
          print("ERROR");
          break;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }

  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      // ligação a firebase
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // guardar na base de dados
      FirebaseUser user = result.user;

      // criar novo documento para o utilzador com aquele uid
      await DatabaseService(uid: user.uid).updateUserData(count+1, "User_icon_BLACK-01.png", "Teste1", email, "F", password, 963853790, DateTime.now());
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut().then((onValue){
        _googleSignIn.signOut();
        _facebookLogin.logOut();
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // esqquecer da password
  @override
  Future sendPasswordResetEmail(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(error){
      print(error.toString());
      return null;
    }
  }

}