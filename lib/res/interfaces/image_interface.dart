import 'package:flutter/material.dart';
import 'package:my_portfolio/res/interfaces/image_type.dart';

abstract class ImageInterface {
  String get path;
  ImageType get type;

  Widget get image;

  double get height;
  double get width;

  /// height : width = screenHeight : screenWidth
  double screenHeight(double screenWidth) => screenWidth * height / width;

  /// height : width = screenHeight : screenWidth
  double screenWidth(double screenHeight) => screenHeight * width / height;
}
