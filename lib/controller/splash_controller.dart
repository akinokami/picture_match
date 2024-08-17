import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picture_match/views/screens/game/play_screen.dart';
import 'package:picture_match/views/screens/home._menu.dart';

import '../services/api_repo.dart';
import '../services/api_utils.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

class SplashController extends GetxController {
  final ApiUtils apiUtils = ApiUtils();
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const PlayScreen());
    });
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
