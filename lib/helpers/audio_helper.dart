import 'package:audioplayers/audioplayers.dart';

import '../constants/sound_constants.dart';
import '../services/local_db_service.dart';

class AudioHelper {
  static final AudioPlayer player = AudioPlayer();

  static Future<void> get stopSound async => await player.stop();

  static Future<void> get tapSound async {
    if (LocalDb.isSoundEffectsOn) {
      await stopSound;
      await player.play(AssetSource(SoundConstants.tap));
    }
  }

  static Future<void> get correctnessSound async {
    if (LocalDb.isSoundEffectsOn) {
      await stopSound;
      await player.play(AssetSource(SoundConstants.correctness));
    }
  }

  static Future<void> get wrongfulnessSound async {
    if (LocalDb.isSoundEffectsOn) {
      await stopSound;
      await player.play(AssetSource(SoundConstants.wrongfulness));
    }
  }

  static Future<void> get countdownSound async {
    if (LocalDb.isSoundEffectsOn) {
      await stopSound;
      await player.play(AssetSource(SoundConstants.countdown1));
    }
  }
}
