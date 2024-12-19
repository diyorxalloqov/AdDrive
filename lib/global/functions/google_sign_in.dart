/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String> googleSignIn(BuildContext context) async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],

    // clientId:
    //     '296731054462-hpac5e4nqe8qstqc7o7nerr30mb8sklp.apps.googleusercontent.com',
    // serverClientId:
    //     'https://28678106956-5n8amdov9h6qso36rjgocthbg3kltpvd.apps.googleusercontent.com'
  );
  try {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account != null) {
      // Signed in successfully, now obtain the authentication tokens
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      String? accessToken = googleAuth.accessToken;
      debugPrint(account.displayName.toString());
      debugPrint(account.id.toString());
      debugPrint(account.photoUrl.toString());
      debugPrint(account.serverAuthCode.toString());
      debugPrint(account.email.toString());
      debugPrint(account.toString());
      debugPrint(accessToken.toString());

      return accessToken ?? '';
    } else {
      debugPrint('Google Sign-In canceled');
      return "google_sign error";
    }
  } on PlatformException catch (error) {
    debugPrint('Google Sign-In Error: $error');
    return 'error';
  }
}
