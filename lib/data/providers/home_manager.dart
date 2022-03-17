import 'package:flutter/cupertino.dart';

import '../models/post.dart';

class HomeManager extends ChangeNotifier{
  bool _didSelectedPage = true;
bool get didSelectedPage=>_didSelectedPage;
  void selectedPage(bool selected) {
    _didSelectedPage = selected;
    notifyListeners();
  }
}