import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/res/interfaces/image_type.dart';

/// An interface for image resources in the application.
abstract class ImageInterface {
  /// The path to the image resource.
  String get path;

  /// Constructs the full path to the image resource.
  String makePath(path) => "${(kDebugMode && kIsWeb) ? "" : "assets/"}$path";

  /// The type of the image resource.
  ImageType get type;

  /// Returns the image widget for the resource.
  Widget get image;

  /// Returns the image widget for the resource with a specified size.
  double get height;

  /// Returns the height of the image resource.
  double get width;

  /// height : width = screenHeight : screenWidth
  double screenHeight(double screenWidth) => screenWidth * height / width;

  /// height : width = screenHeight : screenWidth
  double screenWidth(double screenHeight) => screenHeight * width / height;
}
