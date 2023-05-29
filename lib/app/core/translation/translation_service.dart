import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

import 'translation_repository.dart';

class TranslationService {
  TranslationService(this._repository);
  final TranslationRepository _repository;

  final _service = Translation.instance;

  ///Current [Locale].
  Locale get locale => _service.locale;

  ///Supported locales.
  Set<Locale> get locales => _service.supportedLocales;

  ///Init the [TranslationService].
  Future<TranslationService> init() async {
    final locale = _repository.getLocale();
    Translation.setInitial(locale);
    return this;
  }

  ///Changes the app language.
  void changeLanguage(Locale locale) {
    _service.changeLanguage(locale);
    _repository.setLocale(locale);
  }
}
