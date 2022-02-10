import 'package:flutter/cupertino.dart';

class MainTabScreenWidgetModel extends ChangeNotifier {
  var _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  void setCurrentTabIndex(int value) {
    if (value == _currentTabIndex) return;
    _currentTabIndex = value;
    notifyListeners();
  }
}
