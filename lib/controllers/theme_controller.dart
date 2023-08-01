import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {

  static ThemeController instance = ThemeController();

    bool isdartTheme = false;
    changeTheme(){
      isdartTheme = !isdartTheme;
      notifyListeners();
    }
}