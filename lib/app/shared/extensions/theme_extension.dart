import 'package:flutter/material.dart';

extension StatePropertyExtension<T> on T {
  WidgetStateProperty<T> get property => WidgetStatePropertyAll(this);
}
