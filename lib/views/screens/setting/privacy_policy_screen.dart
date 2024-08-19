import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/app_theme.dart';
import '../../../utils/global.dart';
import '../../widgets/custom_game_button.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(
          Global.language == "vi" ? Global.policyHtmlVi : Global.policyHtmlEn);
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
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
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
                ],
              ),
            ),
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
