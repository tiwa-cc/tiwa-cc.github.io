import 'package:my_portfolio/l10n/l10n.dart';

enum Section {
  about,
  profile,
  contact,
  experience,
  coreSkills,
  softwareSkills,
  contents,
  flutterWebContent,
}

List<Section> visibleNavigationSections() => [
  Section.profile,
  Section.contents,
  Section.coreSkills,
  Section.about,
  Section.softwareSkills,
  Section.experience,
  Section.contact,
];

extension SectionTitleExt on Section {
  String title(L10n l10n) {
    return switch (this) {
      Section.about => l10n.aboutTitle,
      Section.profile => l10n.profileTitle,
      Section.contact => l10n.contactTitle,
      Section.experience => l10n.experienceTitle,
      Section.coreSkills => l10n.coreSkillTitle,
      Section.softwareSkills => l10n.softwareSkillTitle,
      Section.contents => l10n.contentsTitle,
      Section.flutterWebContent => '',
    };
  }
}
