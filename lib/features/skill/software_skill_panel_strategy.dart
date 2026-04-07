import 'package:my_portfolio/domain/software_skill.dart';
import 'package:my_portfolio/features/skill/software_skill_presenter.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';

abstract interface class SoftwareSkillPanelStrategy {
  List<SoftwareSkillSectionPresentation> buildSections(
    List<SoftwareSkill> skills,
    L10n l10n,
  );
}

final class CategorizedSoftwareSkillPanelStrategy
    implements SoftwareSkillPanelStrategy {
  const CategorizedSoftwareSkillPanelStrategy();

  @override
  List<SoftwareSkillSectionPresentation> buildSections(
    List<SoftwareSkill> skills,
    L10n l10n,
  ) {
    return SoftwareSkillPresenter.buildCategorizedSections(skills, l10n);
  }
}

final class FlatSoftwareSkillPanelStrategy
    implements SoftwareSkillPanelStrategy {
  const FlatSoftwareSkillPanelStrategy();

  @override
  List<SoftwareSkillSectionPresentation> buildSections(
    List<SoftwareSkill> skills,
    L10n l10n,
  ) {
    return [SoftwareSkillPresenter.buildSection(skills: skills)];
  }
}

final class SoftwareSkillPanelStrategyResolver {
  const SoftwareSkillPanelStrategyResolver._();

  static SoftwareSkillPanelStrategy resolve(BreakpointSize responsive) {
    return switch (responsive.breakpoint) {
      Breakpoint.xs => const CategorizedSoftwareSkillPanelStrategy(),
      Breakpoint.sm => const CategorizedSoftwareSkillPanelStrategy(),
      Breakpoint.md => const CategorizedSoftwareSkillPanelStrategy(),
      Breakpoint.lg => const FlatSoftwareSkillPanelStrategy(),
      Breakpoint.xl => const FlatSoftwareSkillPanelStrategy(),
    };
  }
}
