import 'package:flutter/material.dart';

class MyInputBorder extends OutlineInputBorder {
  const MyInputBorder({this.radius = 4.0, this.width = 1.0});
  const MyInputBorder.radius(this.radius) : width = 1.0;
  const MyInputBorder.width(this.width) : radius = 4.0;

  final double width;
  final double radius;
  @override
  BorderSide get borderSide => BorderSide(width: width);
  @override
  BorderRadius get borderRadius => BorderRadius.circular(radius);
}
