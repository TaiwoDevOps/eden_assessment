import 'dart:convert';

import 'package:eden_app/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kUser = 'user';

abstract class LocalStorage {
  Future<void> cacheUserData(UserModel data);
  UserModel getCachedUserData();
  Future<bool> clearCachedUserData();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl(this.sharedPreferences);
  SharedPreferences sharedPreferences;

  @override
  Future<void> cacheUserData(UserModel data) async {
    if (data.isEmpty) {
      UserModel empty = UserModel.empty();
      await sharedPreferences
        ..remove(kUser)
        ..setString(
          kUser,
          jsonEncode(empty.toJson()),
        );
    } else {
      await sharedPreferences.setString(kUser, jsonEncode(data.toJson()));
    }
  }

  @override
  UserModel getCachedUserData() {
    final userJson = sharedPreferences.getString(kUser);
    if (userJson == null) {
      return UserModel.empty();
    }
    final user = UserModel.fromJson(jsonDecode(userJson));
    return user;
  }

  @override
  Future<bool> clearCachedUserData() {
    final res = sharedPreferences.remove(kUser);
    return res;
  }
}
