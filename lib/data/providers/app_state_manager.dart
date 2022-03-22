import 'package:flutter/cupertino.dart';

import '../setting/app_cache.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  String? token;
  final _appCache = AppCache();

  bool get isInitialized => _initialized;

  Future<void> initial() async {
    this.token = await _appCache.getToken();

  }
  void setToken(String token){
    _appCache.setToken(token);
    this.token=token;

  }
}
