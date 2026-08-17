import 'package:flutter/material.dart';
import 'package:web_app/NotificationScreen/NotificationController.dart';
import 'package:web_app/NotificationScreen/Widget/NotificationScreenWidget.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());

    return const Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: NotificationScreenWidget(),
    );
  }
}