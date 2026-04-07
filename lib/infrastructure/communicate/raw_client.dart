import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/domain/about.dart';
import 'package:my_portfolio/domain/content_entry.dart';
import 'package:my_portfolio/domain/core_skill.dart';
import 'package:my_portfolio/domain/experience.dart';
import 'package:my_portfolio/domain/software_skill.dart';
import 'package:my_portfolio/infrastructure/communicate/sever_api_interface.dart';
import 'package:my_portfolio/res/asset_about.dart';
import 'package:my_portfolio/res/asset_content_showcase.dart';
import 'package:my_portfolio/res/asset_core_skill.dart';
import 'package:my_portfolio/res/asset_experience.dart';
import 'package:my_portfolio/res/asset_software_skill.dart';
import 'package:my_portfolio/shared/providers.dart';

class RawClient implements SeverApiInterface {
  Ref ref;
  RawClient({required this.ref});

  @override
  Future<AboutResponse> aboutIndex(AboutRequest request) async {
    final storage = ref.read(storageAccessProvider);
    final locale = ref.read(activeLocaleProvider);
    final asset = AssetAbout(locale: locale);
    final map = await asset.decodedJson();
    final about = About.fromJson(map['aboutSection'] as Map<String, dynamic>);
    if (!_isCurrentLocale(locale)) {
      return Future.value(AboutResponse(id: 0));
    }
    storage.replaceAbout(about);

    final result = AboutResponse(id: 0);
    return Future.value(result);
  }

  @override
  Future<ContentResponse> contentIndex(ContentRequest request) async {
    final storage = ref.read(storageAccessProvider);
    final locale = ref.read(activeLocaleProvider);
    final asset = AssetContentShowcase(locale: locale);
    final map = await asset.decodedJson();
    final entries = (map['contents'] as List)
        .map((e) => ContentEntry.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
    if (!_isCurrentLocale(locale)) {
      return Future.value(ContentResponse(id: 0));
    }
    storage.replaceContentEntryList(entries);

    final result = ContentResponse(id: 0);
    return Future.value(result);
  }

  @override
  Future<CoreSkillResponse> coreSkillIndex(CoreSkillRequest request) async {
    final storage = ref.read(storageAccessProvider);
    final locale = ref.read(activeLocaleProvider);
    final asset = AssetCoreSkill(locale: locale);
    final map = await asset.decodedJson();
    final coreSkills = (map['coreSkills'] as List)
        .map((e) => CoreSkill.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
    if (!_isCurrentLocale(locale)) {
      return Future.value(CoreSkillResponse(id: 0));
    }
    storage.replaceCoreSkillList(coreSkills);

    final result = CoreSkillResponse(id: 0);
    return Future.value(result);
  }

  @override
  Future<SoftwareSkillResponse> softwareSkillIndex(
    SoftwareSkillRequest request,
  ) async {
    final storage = ref.read(storageAccessProvider);
    final asset = AssetSoftwareSkill();
    final map = await asset.decodedJson();
    final softwareSkills = (map['softwareSkills'] as List)
        .map((e) => SoftwareSkill.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
    storage.replaceSoftwareSkillList(softwareSkills);

    final result = SoftwareSkillResponse(id: 0);
    return Future.value(result);
  }

  @override
  Future<ExperienceResponse> experienceIndex(ExperienceRequest request) async {
    final storage = ref.read(storageAccessProvider);
    final locale = ref.read(activeLocaleProvider);
    final asset = AssetExperience(locale: locale);
    final map = await asset.decodedJson();
    final experiences = (map['experienceAreas'] as List)
        .map((e) => Experience.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
    if (!_isCurrentLocale(locale)) {
      return Future.value(ExperienceResponse(id: 0));
    }
    storage.replaceExperienceList(experiences);

    final result = ExperienceResponse(id: 0);
    return Future.value(result);
  }

  bool _isCurrentLocale(Locale locale) {
    final currentLocale = ref.read(activeLocaleProvider);
    return currentLocale.languageCode == locale.languageCode;
  }
}
