import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memofy/models/settings/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'box_manager.dart';

class SettingsService {
  late final Future<Box<Settings>> _box;
  ValueListenable<Object>? _listenableBox;

  Future<Box<Settings>> get box{
    return _box;
  }

  Future<void> load(Function f) async {
    _box = BoxManager().openSettingsBox();
    await f();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(() => f());
  }

  Future<Settings?> getSettingsByKey(String key) async {
    return (await _box).get(key);
  }

  Future<Settings> addSettings(String lang, String key) async {
    final settings = Settings(lang: lang);
    (await _box).put(key, settings);

    return settings;
  }

  Future<void> updateSettingsLang(Settings settings, String lang) async {
    settings.lang = lang;
    settings.save();
  }

  Future<void> close(Function f) async {
    _listenableBox?.removeListener(() => f());
    await BoxManager().closeBox((await _box));
  }
}
