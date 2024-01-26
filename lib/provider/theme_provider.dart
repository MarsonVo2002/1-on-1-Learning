import 'package:flutter/material.dart';
import 'package:lettutor/theme/theme.dart';

class ThemeProvider extends ChangeNotifier
{
  ThemeData theme = lightMode;
  bool isLight = true;
  void setTheme()
  {
    if(theme == lightMode)
    {
      theme = darkMode;
      isLight = false;
    }
    else{
      theme  = lightMode;
      isLight = true;
    }
    notifyListeners();
  }
}