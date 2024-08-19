import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:picture_match/utils/constants.dart';
import 'package:picture_match/views/screens/setting/setting_screen.dart';
import 'package:picture_match/views/widgets/custom_game_button.dart';
import 'package:picture_match/views/widgets/game_options.dart';

import '../../../utils/app_theme.dart';
import '../../widgets/custom_text.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({super.key});

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   backgroundColor: AppTheme.white,
      //   iconTheme: const IconThemeData(color: AppTheme.black),
      //   title: CustomText(
      //     text: '',
      //     size: 15.sp,
      //     fontWeight: FontWeight.w500,
      //   ),
      //   actions: <Widget>[
      //     CustomGameButton(
      //       onTap: () {
      //         Get.to(() => const SettingScreen());
      //       },
      //       height: 20.w,
      //       width: 20.w,
      //       icon: Icons.settings,
      //       iconSize: 3.sp,
      //       iconColor: AppTheme.white,
      //     ),
      //   ],
      // ),
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
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomGameButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    height: 35.w,
                    width: 35.w,
                    icon: Icons.arrow_back,
                    iconColor: AppTheme.white,
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
            ),
            CustomText(
              text: 'choose_level'.tr,
              size: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: AppTheme.greyTicket,
                  borderRadius: BorderRadius.circular(
                    25.r,
                  ),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: tabController,
                  onTap: (value) {
                    //
                  },
                  padding: EdgeInsets.all(5.w),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.r,
                    ),
                    color: AppTheme.green,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(
                      text: 'easy'.tr,
                    ),
                    Tab(
                      text: 'normal'.tr,
                    ),
                    Tab(
                      text: 'hard'.tr,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  GameOptions(gameType: GameType.easy.name),
                  GameOptions(gameType: GameType.normal.name),
                  GameOptions(gameType: GameType.hard.name),
                ],
              ),
            ),
          ]),
        ),
      ),
      //  const Center(
      //   child: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         // Text(
      //         //   gameTitle,
      //         //   style: TextStyle(fontSize: 24, color: Colors.black),
      //         // ),
      //         GameOptions(),
      //       ]),
      // ),
    );
  }
}
