import 'package:flutter/material.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:get/get.dart';
import 'package:web_app/SettingScreen/SettingScreenController.dart';
import 'package:web_app/SettingScreen/Widget/SettingScreenWidget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingScreenController());

    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SettingScreenWidget(),
    );
  }
}
