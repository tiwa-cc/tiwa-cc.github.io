import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';
import 'package:my_portfolio/res/interfaces/image_type.dart';

final class AssetProfile extends ImageInterface {
  @override
  String get path => makePath('profile.svg');
  @override
  ImageType get type => ImageType.svgAsset;

  @override
  Widget get image => SvgPicture.asset(path, width: 240);
  @override
  double get height => 512.0;
  @override
  double get width => 512.0;
}
