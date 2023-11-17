// local persistence

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kUser = 'user';

abstract class LocalStorage {
  Future<void> cacheUserData(User? data);
  User? getCachedUserData();
  Future<bool> clearCachedUserData();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl(this.sharedPreferences);
  SharedPreferences sharedPreferences;

  @override
  Future<void> cacheUserData(User? data) async {
    if (data == null) {
      await sharedPreferences.remove(kUser);
    } else {
      //Note: username is 0 and email is 1
      await sharedPreferences.setString(kUser, data.toString());
    }
  }

  @override
  User? getCachedUserData() {
    final userJson = sharedPreferences.getString(kUser);
    if (userJson == null) {
      return null;
    }
    final user = jsonDecode(userJson) as User;
    return user;
  }

  @override
  Future<bool> clearCachedUserData() {
    final res = sharedPreferences.remove(kUser);
    return res;
  }
}
