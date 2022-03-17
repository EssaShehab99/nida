import 'package:flutter/cupertino.dart';

class ConnectUsManager extends ChangeNotifier{
  bool _didSelectedPage = false;

bool get didSelectedPage=>_didSelectedPage;
  void selectedPage(bool selected) {
    _didSelectedPage = selected;
    notifyListeners();
  }
}