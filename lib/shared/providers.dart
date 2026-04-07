import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/app/interface/about_controller_interface.dart';
import 'package:my_portfolio/app/interface/content_controller_interface.dart';
import 'package:my_portfolio/app/interface/core_skill_controller_interface.dart';
import 'package:my_portfolio/app/interface/experience_controller_interface.dart';
import 'package:my_portfolio/app/interface/software_skill_controller_interface.dart';
import 'package:my_portfolio/infrastructure/communicate/rest_client.dart';
import 'package:my_portfolio/infrastructure/communicate/sever_api_interface.dart';
import 'package:my_portfolio/infrastructure/repository/api_repository.dart';
import 'package:my_portfolio/infrastructure/storage/db_accessor.dart';
import 'package:my_portfolio/infrastructure/storage/storage_access_interface.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';
import 'package:my_portfolio/shared/parts/layout_width_preset.dart';

////////////////////////////////////////////////////////////////
// System
////////////////////////////////////////////////////////////////
///
final routeObserverProvider = Provider<RouteObserver<ModalRoute<void>>>(
  (ref) => RouteObserver<ModalRoute<void>>(),
);

final localeOverrideProvider = StateProvider<Locale?>((ref) => null);

final layoutWidthPresetProvider = StateProvider<LayoutWidthPreset>(
  (ref) => LayoutWidthPreset.auto,
);

final activeLocaleProvider = Provider<Locale>((ref) {
  final override = ref.watch(localeOverrideProvider);
  if (override != null) {
    return L10n.resolveLocale(override);
  }

  return L10n.resolveLocaleList(
    WidgetsBinding.instance.platformDispatcher.locales,
    L10n.supportedLocales,
  );
});

/// A provider that holds the current breakpoint size.
final breakpointSizeProvider = StateNotifierProvider(
  (ref) => BreakpointSizeNotifier(),
);

/// A notifier that manages the current breakpoint size.
final topViewScrollPositionProvider = StateProvider<double>((ref) {
  return 0.0; // Default scroll position
});

////////////////////////////////////////////////////////////////
// ViewModel
////////////////////////////////////////////////////////////////
final aboutProvider = StreamProvider.autoDispose((ref) {
  final storage = ref.watch(storageAccessProvider);
  return storage.watchAbout();
});

final contentEntryListProvider = StreamProvider.autoDispose((ref) {
  final storage = ref.watch(storageAccessProvider);
  return storage.watchContentEntryList();
});

final coreSkillListProvider = StreamProvider.autoDispose((ref) {
  final storage = ref.watch(storageAccessProvider);
  return storage.watchCoreSkillList();
});

final softwareSkillListProvider = StreamProvider.autoDispose((ref) {
  final storage = ref.watch(storageAccessProvider);
  return storage.watchSoftwareSkillList();
});

final experienceListProvider = StreamProvider.autoDispose((ref) {
  final storage = ref.watch(storageAccessProvider);
  return storage.watchExperienceList();
});

////////////////////////////////////////////////////////////////
// Controller
////////////////////////////////////////////////////////////////
final aboutControllerProvider = StateProvider((ref) {
  final api = ref.watch(serverApiProvider);
  return AboutController(apiRepo: ApiRepository(api: api));
});

final contentControllerProvider = StateProvider((ref) {
  final api = ref.watch(serverApiProvider);
  return ContentController(apiRepo: ApiRepository(api: api));
});

final coreSkillControllerProvider = StateProvider((ref) {
  final api = ref.watch(serverApiProvider);
  return CoreSkillController(apiRepo: ApiRepository(api: api));
});

final softwareSkillControllerProvider = StateProvider((ref) {
  final api = ref.watch(serverApiProvider);
  return SoftwareSkillController(apiRepo: ApiRepository(api: api));
});

final experienceControllerProvider = StateProvider((ref) {
  final api = ref.watch(serverApiProvider);
  return ExperienceController(apiRepo: ApiRepository(api: api));
});

////////////////////////////////////////////////////////////////
// Infrastructure
////////////////////////////////////////////////////////////////
final serverApiProvider = Provider<SeverApiInterface>(
  (ref) => RestClient(Dio()),
);

final storageAccessProvider = Provider<StorageAccessInterface>(
  (ref) => DBAccessor(),
);
