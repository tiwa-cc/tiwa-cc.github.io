import 'package:flutter/material.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';
import 'package:my_portfolio/res/interfaces/image_type.dart';

final class AssetHeaderBg extends ImageInterface {
  @override
  String get path => makePath('header-bg.png');
  @override
  ImageType get type => ImageType.imageAsset;

  @override
  Widget get image => Image.asset(path);
  @override
  double get height => 640.0;
  @override
  double get width => 1536.0;
}
