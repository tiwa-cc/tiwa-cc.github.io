import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';
import 'package:my_portfolio/res/interfaces/image_type.dart';

/// An asset representing the subtitle image.
final class AssetTitle extends ImageInterface {
  @override
  String get path => makePath('title.svg');
  @override
  ImageType get type => ImageType.svgAsset;

  @override
  Widget get image => SvgPicture.asset(path, width: 1200);
  @override
  double get height => 113.0;
  @override
  double get width => 1134.0;
  @override
  double screenHeight(double screenWidth) => screenWidth * height / width;
  @override
  double screenWidth(double screenHeight) => 1200;
}
