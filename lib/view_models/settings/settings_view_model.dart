import 'package:flutter/foundation.dart';
import 'package:memofy/constants/constants.dart';
import 'package:memofy/data/settings_service.dart';
import 'package:memofy/models/settings/settings.dart';

class SettingsViewModel extends ChangeNotifier {
  final settingsService = SettingsService();
  var settings = Settings(lang: '');

  SettingsViewModel() {
    load();
  }

  Future<void> _readSettingsFromHive() async {
    settings = (await settingsService.getSettingsByKey(settings_key))!;
    print( '_readSettingsFromHive : $settings');
    notifyListeners();
  }

  Settings getSettings(){
    print( 'getSettings :  $settings');
    return settings;
  }

  Future<void> load() async {
    await settingsService.load(_readSettingsFromHive);
  }

  Future<void> updateSettingsLang(String lang) async {
    settingsService.updateSettingsLang(settings, lang);
    notifyListeners();
  }


}