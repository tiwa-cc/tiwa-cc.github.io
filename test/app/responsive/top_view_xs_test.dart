import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/responsive/top_view_xs.dart';
import 'package:my_portfolio/app/section.dart';

void main() {
  test('prioritizes contents and skills in xs order', () {
    expect(TopViewXs.orderedSections(), [
      Section.profile,
      Section.contents,
      Section.coreSkills,
      Section.about,
      Section.softwareSkills,
      Section.experience,
      Section.contact,
    ]);
  });

  test('shows scroll jumpers after the primary xs sections', () {
    expect(TopViewXs.showsScrollJumperAfter(Section.profile), isTrue);
    expect(TopViewXs.showsScrollJumperAfter(Section.about), isTrue);
    expect(TopViewXs.showsScrollJumperAfter(Section.contents), isTrue);
    expect(TopViewXs.showsScrollJumperAfter(Section.coreSkills), isTrue);
    expect(TopViewXs.showsScrollJumperAfter(Section.softwareSkills), isTrue);
    expect(TopViewXs.showsScrollJumperAfter(Section.experience), isTrue);
    expect(TopViewXs.showsScrollJumperAfter(Section.contact), isTrue);
  });
}
