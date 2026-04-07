import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/l10n/l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('returns all visible navigation sections in intended order', () {
    expect(visibleNavigationSections(), [
      Section.profile,
      Section.contents,
      Section.coreSkills,
      Section.about,
      Section.softwareSkills,
      Section.experience,
      Section.contact,
    ]);
  });

  test('resolves localized section titles', () async {
    final l10n = await L10n.load(const Locale('ja'));

    expect(Section.profile.title(l10n), 'イントロ');
    expect(Section.contents.title(l10n), '代表的な取り組み');
  });
}
