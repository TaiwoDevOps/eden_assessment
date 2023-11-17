import 'package:eden_app/core/di.dart';
import 'package:eden_app/core/local_storage.dart';
import 'package:eden_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:eden_app/features/auth/data/model/user_model.dart';
import 'package:eden_app/utils/log_util.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final Auth auth = Auth();

  UserModel _userData = UserModel.empty();
  UserModel get userData => _userData;
  set userData(UserModel value) {
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
    final userObject = sl<LocalStorage>().getCachedUserData();
    if (!userObject.isEmpty) {
      userData = userObject;
      Log().debug('The user data', userData.toJson());
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    loading = true;
    final val = await auth.signInWithGoogle(context);
    await handleUserData(val);
    loading = false;
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    gLoading = true;
    final val = await auth.signInWithGitHub(context);
    await handleUserData(val);

    gLoading = false;
  }

  Future<void> handleUserData(UserModel user) async {
    if (!user.isEmpty) {
      userData = user;
      await sl<LocalStorage>()
        ..clearCachedUserData()
        ..cacheUserData(userData);
    }
  }

  Future<void> handleSignOut() async {
    userData = UserModel.empty();
    await auth.handleSignOut();
    await sl<LocalStorage>().clearCachedUserData();
  }
}
