import 'package:flutter/material.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:get/get.dart';
import 'package:web_app/TimerScreen/TimerScreenController.dart';
import 'package:web_app/TimerScreen/Widget/TimeScreenWidget.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TimerScreenController());

    return  Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: TimerScreenWidget(),
    );
  }
}
