import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SidebarWebController extends GetxController {
   // Top Navigation
  var selected = "Timer".obs;
  var notificationCount = 4.obs;

  void selectMenu(String title) {
    selected.value = title;
  }

  void syncWithRoute(String route) {
    if (route.contains('timer')) {
      selected.value = "Timer";
    } else if (route.contains('notification')) {
      selected.value = "Notification";
    } else if (route.contains('settings')) {
      selected.value = "Settings";
    } else if (route.contains('help')) {
      selected.value = "Help Center";
    }
  }

  // Timer logic
  var isRunning = false.obs;
  var seconds = 0.obs;
  Timer? _timer;

  void toggleTimer() {
    if (isRunning.value) {
      _timer?.cancel();
      isRunning.value = false;
    } else {
      isRunning.value = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        seconds.value++;
      });
    }
  }

  String get formattedTime {
    int h = seconds.value ~/ 3600;
    int m = (seconds.value % 3600) ~/ 60;
    int s = seconds.value % 60;
    return "$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  void signOut(BuildContext context) {
    print("User Signed Out");
    context.go('/login');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}