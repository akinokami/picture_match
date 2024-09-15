import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picture_match/language/languages.dart';
import 'package:picture_match/views/screens/splash_screen.dart';
import 'utils/global.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Global.language = box.read('language') ?? "zh";
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'picture_match'.tr,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          // theme: CustomTheme.lightTheme,
          // darkTheme: CustomTheme.darkTheme,
          // themeMode: ThemeMode.system,
          translations: Languages(),
          locale: Global.language == 'zh'
              ? const Locale('zh', 'CN')
              : Global.language == 'vi'
                  ? const Locale('vi', 'VN')
                  : const Locale('en', 'US'),
          fallbackLocale: const Locale('zh', 'CN'),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
