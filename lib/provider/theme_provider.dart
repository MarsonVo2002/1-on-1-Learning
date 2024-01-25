import 'package:flutter/material.dart';
import 'package:lettutor/theme/theme.dart';

class ThemeProvider extends ChangeNotifier
{
  ThemeData theme = lightMode;
  void setTheme()
  {
    if(theme == lightMode)
    {
      theme = darkMode;
    }
    else{
      theme  = lightMode;
    }
    notifyListeners();
  }
}