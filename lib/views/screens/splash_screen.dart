import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';
import '../../utils/app_theme.dart';
import '../widgets/custom_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(size: 80.sp),
            SizedBox(height: 30.h),
            CustomText(
              text: 'picture_match'.tr,
              size: 14.sp,
            ),
            SizedBox(height: 30.h),
            const CircularProgressIndicator(
              color: AppTheme.green,
            ),
          ],
        ),
      ),
    );
  }
}
