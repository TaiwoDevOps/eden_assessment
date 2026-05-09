import 'package:eden_app/utils/log_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eden_app/core/di.dart' as locator;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

class AppSetups {
  static Future<void> runSetups() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load();

    //Logger
    Log.init();

    // init firebase service
    app = await Firebase.initializeApp();
    auth = FirebaseAuth.instanceFor(app: app);

    // init service locator
    await locator.initServiceLocator();
  }
}
