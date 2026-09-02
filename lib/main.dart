import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/app/app.dart';
import 'package:amna_food_industries_mobile_app/core/app/app_initializer.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      debugPrint('Uncaught error: $error\n$stack');
      return true;
    };

    await AppInitializer.setup();
    runApp(const AmnaFoodApp());
  }, (error, stack) => debugPrint('Zone error: $error\n$stack'));
}
