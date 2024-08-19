import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picture_match/views/screens/game/startup_page.dart';
import 'package:picture_match/views/screens/setting/setting_screen.dart';
import 'package:picture_match/views/widgets/custom_game_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controller/sound_controller.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/global.dart';
import '../../widgets/custom_text.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    first = box.read('first') ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 1.sh * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height: 1.sh * 0.65,
                                  width: double.infinity,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString(Global.language == "vi"
                                            ? Global.policyHtmlVi
                                            : Global.policyHtmlEn))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: AppTheme.green,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked
                                        ? AppTheme.green
                                        : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'agree'.tr,
                                  size: 12,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          isAccepted
                                              ? AppTheme.green
                                              : AppTheme.greyTicket)),
                              // ignore: sort_child_properties_last
                              child: CustomText(
                                text: 'accept'.tr,
                                size: 12,
                              ),
                              onPressed: isAccepted
                                  ? () async {
                                      final box = GetStorage();
                                      box.write('first', 'notfirst');
                                      Navigator.pop(context);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final soundController = Get.put(SoundController());
    soundController.playSound();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/bg.webp",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomGameButton(
                      onTap: () {
                        exit(0);
                      },
                      height: 35.w,
                      width: 35.w,
                      icon: Icons.close,
                      iconColor: AppTheme.white,
                      color1: Colors.red,
                      color2: Colors.red.shade300,
                      color3: Colors.red,
                    ),
                    CustomGameButton(
                      onTap: () {
                        Get.to(() => const SettingScreen());
                      },
                      height: 35.w,
                      width: 35.w,
                      icon: Icons.settings,
                      iconColor: AppTheme.white,
                    ),
                  ],
                ),
                SizedBox(height: 120.h),
                Image.asset(
                  'assets/images/logo.webp',
                  height: 80.h,
                ),
                SizedBox(height: 30.h),
                CustomText(
                  text: 'picture_match'.tr,
                  size: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 40.h),
                CustomGameButton(
                  onTap: () {
                    Get.to(() => const StartUpPage());
                  },
                  width: 0.2.sh,
                  text: 'play'.tr,
                  textColor: AppTheme.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
