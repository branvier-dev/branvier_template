// ignore_for_file: prefer_match_file_name
import 'package:flutter/material.dart';

extension StatePropertyExtension<T> on T {
  WidgetStateProperty<T> get property => WidgetStatePropertyAll(this);
}
