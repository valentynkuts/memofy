import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 2)
class Settings extends HiveObject {
  @HiveField(0)
  String lang;

  Settings({required this.lang});

  @override
  String toString() {
    return 'Settings{lang: $lang}';
  }
}
