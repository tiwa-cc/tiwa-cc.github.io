import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:my_portfolio/res/asset_path.dart';

final class AssetSoftwareSkill {
  const AssetSoftwareSkill();

  static String get path => resolveAssetPath('mock/software_skill.json');

  Future<Map<String, dynamic>> decodedJson() async {
    final json = await rootBundle.loadString(path);
    final map = jsonDecode(json) as Map<String, dynamic>;
    return map;
  }
}
