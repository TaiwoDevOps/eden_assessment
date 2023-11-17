import 'package:eden_app/core/di.dart';
import 'package:eden_app/core/local_storage.dart';
import 'package:eden_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:eden_app/utils/log_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final Auth auth = Auth();

  User? _userData;
  User? get userData => _userData;
  set userData(User? value) {
    _userData = value;
    notifyListeners();
  }

  bool _gLoading = false;
  bool get gLoading => _gLoading;
  set gLoading(bool value) {
    _gLoading = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  init() {
    // if user object exist, on login... welcome back user using email
    // else, infirm user to sign up
    final userObject = sl<LocalStorage>().getCachedUserData();
    if (userObject != null) {
      userData = userObject;
    }
  }

  Future<void> signInWithGoogle() async {
    loading = true;
    final val = await auth.signInWithGoogle();
    await handleUserData(val.user);
    loading = false;
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    gLoading = true;
    final val = await auth.signInWithGitHub(context);
    await handleUserData(val.user);

    gLoading = false;
  }

  Future<void> handleUserData(User? user) async {
    if (user != null) {
      userData = user;
      await sl<LocalStorage>()
        ..clearCachedUserData()
        ..cacheUserData(userData);
    }
  }

  //
}
