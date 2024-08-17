import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picture_match/views/screens/game/startup_page.dart';
import 'package:picture_match/views/screens/setting/setting_screen.dart';
import 'package:picture_match/views/widgets/game_button.dart';
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
    Get.put(SoundController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    exit(0);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.sp,
                    color: AppTheme.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => const SettingScreen());
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 30.sp,
                    color: AppTheme.green,
                  ),
                )
              ],
            ),
            SizedBox(height: 120.h),
            FlutterLogo(
              size: 80.sp,
            ),
            SizedBox(height: 30.h),
            CustomText(
              text: 'picture_match'.tr,
              size: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 40.h),
            GameButton(
                onPressed: () {
                  Get.to(() => const StartUpPage());
                },
                title: 'play'.tr,
                color: AppTheme.green)
          ],
        ),
      ),
    );
  }
}
