import 'package:flutter/material.dart';
import 'package:web_app/HelpCenterScreen/HelpCenterController.dart';
import 'package:web_app/HelpCenterScreen/Widget/HelpCenterScreenWidget.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:get/get.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HelpCenterController());

    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: HelpCenterScreenWidget(),
    );
  }
}