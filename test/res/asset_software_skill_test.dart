import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/res/asset_software_skill.dart';

void main() {
  test('AssetSoftwareSkill resolves asset path', () {
    expect(
      AssetSoftwareSkill.path,
      anyOf('mock/software_skill.json', 'assets/mock/software_skill.json'),
    );
  });
}
