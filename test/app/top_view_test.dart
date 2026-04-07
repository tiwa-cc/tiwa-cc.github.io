import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/app/top_view.dart';

void main() {
  test('builds a key map for every section', () {
    final aboutKey = GlobalKey();
    final profileKey = GlobalKey();
    final contentsKey = GlobalKey();

    final result = resolveSectionGlobalKeys(
      const [Section.about, Section.profile, Section.contents],
      (section) => switch (section) {
        Section.about => aboutKey,
        Section.profile => profileKey,
        Section.contents => contentsKey,
        _ => GlobalKey(),
      },
    );

    expect(result, hasLength(3));
    expect(result[Section.about], same(aboutKey));
    expect(result[Section.profile], same(profileKey));
    expect(result[Section.contents], same(contentsKey));
  });
}
