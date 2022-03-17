import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../setting/app_cache.dart';

class AppStateManager extends ChangeNotifier{
  bool _initialized = false;
  bool _splashComplete = false;
  final _appCache = AppCache();

  bool get isInitialized => _initialized;

  void initializeApp() async {
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

}