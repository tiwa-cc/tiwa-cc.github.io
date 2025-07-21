import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';
import 'package:my_portfolio/res/interfaces/image_type.dart';

/// An asset representing the navbar logo.
final class AssetNavbarLogo extends ImageInterface {
  @override
  String get path => makePath('navbar-logo.svg');
  @override
  ImageType get type => ImageType.svgAsset;

  @override
  Widget get image => SvgPicture.asset(path);
  @override
  double get height => 51.0;
  @override
  double get width => 300.0;
}
