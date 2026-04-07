import 'package:my_portfolio/domain/about.dart';
import 'package:my_portfolio/domain/content_entry.dart';
import 'package:my_portfolio/domain/core_skill.dart';
import 'package:my_portfolio/domain/experience.dart';
import 'package:my_portfolio/domain/software_skill.dart';

abstract interface class StorageAccessInterface {
  Stream<About> watchAbout();
  Stream<void> insertOrUpdateAbout(About entity);
  void replaceAbout(About entity);
  Stream<List<ContentEntry>> watchContentEntryList();
  Stream<void> insertOrUpdateContentEntry(ContentEntry entity);
  void replaceContentEntryList(List<ContentEntry> entities);
  Stream<List<CoreSkill>> watchCoreSkillList();
  Stream<void> insertOrUpdateCoreSkill(CoreSkill entity);
  void replaceCoreSkillList(List<CoreSkill> entities);
  Stream<List<SoftwareSkill>> watchSoftwareSkillList();
  Stream<void> insertOrUpdateSoftwareSkill(SoftwareSkill entity);
  void replaceSoftwareSkillList(List<SoftwareSkill> entities);
  Stream<List<Experience>> watchExperienceList();
  Stream<void> insertOrUpdateExperience(Experience entity);
  void replaceExperienceList(List<Experience> entities);
}
