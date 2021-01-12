import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoginProvider {
  GOOGLE,
}

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn;
  // FacebookLogin _facebookSignIn;

  AuthenticationService();

  Future logout() async {
    try {
      await _googleSignIn?.signOut();
      await _auth.signOut();
    } catch (e) {
      throw e;
    }

    return;
  }

  User getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User> login(LoginProvider provider) {
    switch (provider) {
      case LoginProvider.GOOGLE:
        return _googleLogin();
      default:
        return _googleLogin();
    }
  }

  Future<User> _googleLogin() async {
    try {
      if (null == _googleSignIn) {
        _googleSignIn = GoogleSignIn(
          hostedDomain: "",
          clientId: "",
        );
      }

      await _googleSignIn.signOut();

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // print(googleUser.email);
      // print(googleUser.displayName);

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var res = await _auth.signInWithCredential(credential);

      if (null != res.user) {
        print('Logged in: ${res.user.email}');
        // additional step for sync
        // if (res.user.photoUrl == null && googleUser.photoUrl != null) {
        //   UserUpdateInfo updateUser = UserUpdateInfo();
        //   updateUser.photoUrl = googleUser.photoUrl;
        //   await res.user.updateProfile(updateUser);
        // }
      }

      return res.user;
    } on NoSuchMethodError catch (e) {
      print('User cancelled');
      return null;
    } catch (e) {
      print(e);
      throw Exception('Error encountered. Please try again.');
    }
  }

  Future<User> emailLogin({String email, String password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("email login failed ${email} ${password}");
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<User> createAuth({String email, String password}) async {
    try {
      print("creating auth user ${email} ${password}");
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.signInWithEmailAndPassword(email: email, password: password);
      await result.user.sendEmailVerification();
      return result.user;
    } catch (e) {
      print("failed creating email password");
      throw Exception('Error encountered. Please try again.');
    }
  }
}
