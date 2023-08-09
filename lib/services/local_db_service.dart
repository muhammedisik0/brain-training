import 'package:get_storage/get_storage.dart';

class LocalDb {
  static final GetStorage _localDbBox = GetStorage('BrainMax');

  static bool get isLanguageEnglish => _localDbBox.read('isLanguageEnglish') ?? true;

  static Future<void> setLanguage() async =>
      await _localDbBox.write('isLanguageEnglish', !isLanguageEnglish);

  static bool get isSoundEffectsOn => _localDbBox.read('isSoundEffectsOn') ?? true;

  static void setSoundEffects() => _localDbBox.write('isSoundEffectsOn', !isSoundEffectsOn);
}
