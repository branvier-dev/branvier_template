import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';

/// [TranslationRepository] encapsulates all data processing of [Theme].
class TranslationRepository {
  TranslationRepository(this._box);
  static const key = 'locale';

  //Dependencies
  final IBox _box;

  ///Gets the [Locale] on cache.
  Locale getLocale() {
    final languageCode = _box.read(key, or: 'pt_BR')!;
    return languageCode.toLocale();
  }

  ///Sets the [Locale] on cache.
  void setLocale(Locale locale) async {
    await _box.write(key, locale.toString());
  }
}
