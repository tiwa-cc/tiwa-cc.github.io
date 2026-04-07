import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';
import 'package:my_portfolio/res/interfaces/image_type.dart';

/// An asset representing the subtitle image.
final class AssetSubtitle extends ImageInterface {
  @override
  String get path => makePath('subtitle.svg');
  @override
  ImageType get type => ImageType.svgAsset;

  @override
  Widget get image => SvgPicture.asset(path, width: 600);
  @override
  double get height => 30.103588;
  @override
  double get width => 464.05771;
}
