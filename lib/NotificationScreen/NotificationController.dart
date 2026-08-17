
import 'package:get/get.dart';

class NotificationModel {
  final String title;
  final String description;
  final String time;
  final String type;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

class NotificationController extends GetxController {
  var selectedTab = 'All'.obs;
  var searchQuery = ''.obs;
  var selectedGroupBy = 'Date'.obs;
  var currentPage = 1.obs;
  final int totalPages = 5;

  final RxList<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(
      title: "Tracking Started",
      description: "Your work session started successfully.",
      time: "Today • 09:00 AM",
      type: "started",
      isRead: false,
    ),
    NotificationModel(
      title: "Tracking Stopped",
      description: "Your work session ended successfully.",
      time: "Today • 09:00 AM",
      type: "stopped",
      isRead: true,
    ),
    NotificationModel(
      title: "Idle Warning",
      description: "Your work session ended successfully.",
      time: "Today • 09:00 AM",
      type: "warning",
      isRead: false,
    ),
    NotificationModel(
      title: "Data Synced",
      description: "Your tracked data has been synchronized successfully.",
      time: "Today • 09:00 AM",
      type: "synced",
      isRead: true,
    ),
    NotificationModel(
      title: "Screenshot Captured",
      description: "A screenshot was captured successfully.",
      time: "Today • 09:00 AM",
      type: "screenshot",
      isRead: false,
    ),
  ].obs;

  List<NotificationModel> get filteredNotifications {
    return notifications.where((item) {
      bool matchesTab = selectedTab.value == 'All' || !item.isRead;
      bool matchesSearch = item.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();
  }

  void nextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void previousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }
}