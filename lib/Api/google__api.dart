import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.disconnect();
}
