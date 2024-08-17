import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SoundController extends GetxController {
  final player = AudioPlayer();
  final isMuted = false.obs;
  final isVibrate = false.obs;

  @override
  void onInit() {
    getMute();

    super.onInit();
  }

  void getMute() {
    final box = GetStorage();
    isMuted.value = box.read('isMuted') ?? false;
    muteUnmute();
  }

  void playSound() async {
    player.play(AssetSource('theme_soung.mp3'));
  }

  void muteUnmute() {
    if (isMuted.value) {
      player.setVolume(1.0); // Unmute the audio
    } else {
      player.setVolume(0.0); // Mute the audio
    }
    final box = GetStorage();
    box.write('isMuted', isMuted.value);
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
