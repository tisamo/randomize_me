import 'package:flutter/cupertino.dart';

class NavProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void setNavIndex(indexToNavigate, context) {
    if (indexToNavigate == selectedIndex) return;
    selectedIndex = indexToNavigate;
    notifyListeners();

    switch (indexToNavigate) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 2:
        Navigator.pushNamed(context, '/courses');
            break;
      case 1:
        Navigator.pushNamed(context, '/test');
        break;
      case 3:
        Navigator.pushNamed(context, '/swiper');
        break;
    }

  }
}
