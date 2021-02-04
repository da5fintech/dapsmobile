import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';

enum LoginProvider {
  GOOGLE,
  FACEBOOK,
}

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LocalAuthentication _localAuthentication = LocalAuthentication();
  GoogleSignIn _googleSignIn;
  FacebookLogin _facebookSignIn;

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
      case LoginProvider.FACEBOOK:
        return _facebookLogin();
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

  Future<User> _facebookLogin() async {
    try {
      final _facebookSignIn = FacebookLogin();
      final res = await _facebookSignIn.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email
        ],
      );

      // Check result status
      switch (res.status) {
        case FacebookLoginStatus.success:
          // Logged in

          // Send access token to server for validation and auth
          final FacebookAccessToken accessToken = res.accessToken;
          print('Access token: ${accessToken.token}');

          // Get profile data
          final profile = await _facebookSignIn.getUserProfile();
          print('Hello, ${profile.name}! You ID: ${profile.userId}');

          // Get user profile image url
          final imageUrl = await _facebookSignIn.getProfileImageUrl(width: 100);
          print('Your profile image: $imageUrl');

          // Get email (since we request email permission)
          final email = await _facebookSignIn.getUserEmail();

          // But user can decline permission
          if (email != null) print('And your email is $email');

          final AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);

          var result = await _auth.signInWithCredential(credential);

          if (null != result.user) {
            print('Logged in: ${result.user.email}');
          }

          return result.user;
          break;
        case FacebookLoginStatus.cancel:
          // User cancel log in
          break;
        case FacebookLoginStatus.error:
          // Log in failed
          print('Error while log in: ${res.error}');
          break;
      }
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

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<List> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    print(listOfBiometrics);
    return listOfBiometrics;
  }

  Future<bool> authFingerprint() async {
    bool available = await _isBiometricAvailable();
    if (available) {
      List biometrics = await _getListOfBiometricTypes();
      if (biometrics.isNotEmpty) {
        bool success = await _localAuthentication.authenticateWithBiometrics(
            localizedReason: 'Use Fingerprint to log in');
        return success;
      }
      return false;
    }
    return false;
  }
}
