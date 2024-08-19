import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:picture_match/utils/app_theme.dart';
import 'package:picture_match/views/widgets/custom_game_button.dart';
import 'package:picture_match/views/widgets/game_button.dart';

import '../../utils/constants.dart';

class GameControlsBottomSheet extends StatelessWidget {
  const GameControlsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'pause'.tr,
              style: const TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          // GameButton(
          //   onPressed: () => Navigator.of(context).pop(false),
          //   title: 'continue'.tr,
          //   color: continueButtonColor,
          //   width: 200,
          // ),
          CustomGameButton(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            width: 0.2.sh,
            text: 'continue'.tr,
            textColor: AppTheme.white,
          ),
          const SizedBox(height: 10),
          // GameButton(
          //   onPressed: () => Navigator.of(context).pop(true),
          //   title: 'restart'.tr,
          //   color: restartButtonColor,
          //   width: 200,
          // ),
          CustomGameButton(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            width: 0.2.sh,
            text: 'restart'.tr,
            textColor: AppTheme.white,
            color1: Colors.orange,
            color2: Colors.orange.shade300,
            color3: Colors.orange,
          ),
          const SizedBox(height: 10),
          // GameButton(
          //   onPressed: () {
          //     // Navigator.of(context).pushAndRemoveUntil(
          //     //   MaterialPageRoute(
          //     //     builder: (BuildContext context) {
          //     //       return const StartUpPage();
          //     //     },
          //     //   ),
          //     //   (Route<dynamic> route) => false,
          //     // );
          //     Navigator.pop(context);
          //     Navigator.pop(context);
          //   },
          //   title: 'quit'.tr,
          //   color: quitButtonColor,
          //   width: 200,
          // ),
          CustomGameButton(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            width: 0.2.sh,
            text: 'quit'.tr,
            textColor: AppTheme.white,
            color1: Colors.cyan,
            color2: Colors.cyan.shade300,
            color3: Colors.cyan,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
