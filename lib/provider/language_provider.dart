import 'package:flutter/material.dart';
import 'package:lettutor/model/language/english.dart';
import 'package:lettutor/model/language/language.dart';
import 'package:lettutor/model/language/vietnamese.dart';

class LanguageProvider extends ChangeNotifier {
  Language language = English();
  void setLanguage() {
    if (language.id == 'English') {
      language = Vietnamese();
    } else {
      language = English();
    }
    notifyListeners();
  }
}
