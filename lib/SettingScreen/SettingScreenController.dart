


import 'package:get/get.dart';

class SettingScreenController extends GetxController {
  // Application Preferences
  var launchOnStartup = true.obs;
  var autoStartTracking = true.obs;

  // Appearance & Language
  var selectedTheme = 'Light Mode'.obs;
  var selectedLanguage = 'English (US)'.obs;

  final List<String> themeOptions = ['Light Mode', 'Dark Mode', 'System Default'];
  final List<String> languageOptions = ['English (US)', 'English (UK)', 'Spanish', 'Urdu'];

  // Notification Preferences
  var notificationSound = true.obs;
  var trackingStarted = true.obs;
  var trackingStopped = true.obs;
  var idleTimeWarning = true.obs;
  var synchronizationCompleted = true.obs;
  var systemAnnouncement = true.obs;
}