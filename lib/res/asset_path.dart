import 'package:flutter/foundation.dart';

String resolveAssetPath(String relativePath) {
  return '${(kDebugMode && kIsWeb) ? '' : 'assets/'}$relativePath';
}
