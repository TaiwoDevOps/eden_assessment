import 'package:eden_app/features/auth/data/model/user_model.dart';
import 'package:eden_app/utils/notification_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel> signInWithGoogle(BuildContext context) async {
    late GoogleSignInAccount? googleUser;
    UserModel userModel = UserModel.empty();
    String error = "";
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      if (e is PlatformException) {
        error = e.message.toString();
      } else {
        error = 'Something went wrong';
      }
      showErrorNotification(context, error);
      return userModel;
    }
    // Trigger the authentication flow

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    userModel = userModel.copyWith(
      displayName: user.user?.displayName,
      email: user.user?.email,
      isEmailVerified: user.user?.emailVerified,
      isAnonymous: user.user?.isAnonymous,
      phoneNumber: user.user?.phoneNumber,
      photoURL: user.user?.photoURL,
      refreshToken: user.user?.refreshToken,
      tenantId: user.user?.tenantId,
      uid: user.user?.uid,
    );
    return userModel;
  }

  Future<UserModel> signInWithGitHub(BuildContext context) async {
    late GitHubSignIn gitHubSignIn;
    UserModel userModel = UserModel.empty();
    String error = "";
    try {
      // Create a GitHubSignIn instance
      gitHubSignIn = GitHubSignIn(
          clientId: dotenv.get('GITHUB_CLIENT_ID'),
          clientSecret: dotenv.get('GITHUB_CLIENT_SECRET'),
          redirectUrl:
              'https://fir-auth-5bf85.firebaseapp.com/__/auth/handler');
    } catch (e) {
      if (e is PlatformException) {
        error = e.message.toString();
      } else {
        error = 'Something went wrong';
      }

      showErrorNotification(context, error);
      return userModel;
    }

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);

    // Once signed in, return the UserCredential
    final user =
        await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
    userModel = userModel.copyWith(
      displayName: user.user?.displayName,
      email: user.user?.email,
      isEmailVerified: user.user?.emailVerified,
      isAnonymous: user.user?.isAnonymous,
      phoneNumber: user.user?.phoneNumber,
      photoURL: user.user?.photoURL,
      refreshToken: user.user?.refreshToken,
      tenantId: user.user?.tenantId,
      uid: user.user?.uid,
    );
    return userModel;
  }

  Future<void> handleSignOut() async {
    try {
      await auth.signOut();
    } catch (e) {}
  }
}
