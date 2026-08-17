import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:web_app/Resources/TextString.dart';
import 'package:web_app/Resources/TextTheme.dart';
import 'package:web_app/SettingScreen/SettingScreenController.dart';

class SettingScreenWidget extends StatelessWidget {
  const SettingScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingScreenController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.settingsTitle,
            style: TTextTheme.h1Style(context),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.settingSubtitle,
            style: TTextTheme.titleSix(context),
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            context,
            title:TextString.settingApplicationTitle ,
            subtitle:TextString.settingApplicationSubtitle ,
            children: [
              Obx(() => _buildSwitchTile(
                context,
                title: TextString.settingsApplicationTitleTwo,
                subtitle:TextString.settingsApplicationSubtitleTwo ,
                value: controller.launchOnStartup.value,
                onChanged: (val) => controller.launchOnStartup.value = val,
              )),
              _buildCustomDivider(),
              Obx(() => _buildSwitchTile(
                context,
                title:TextString.settingTrackingTitle ,
                subtitle: TextString.settingTrackingSubtitle,
                value: controller.autoStartTracking.value,
                onChanged: (val) => controller.autoStartTracking.value = val,
              )),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            context,
            title:TextString.settingAppearenceTitle ,
            subtitle:TextString.settingAppearenceSubtitle ,
            children: [
              Obx(() => _buildDropdownTile(
                context,
                title: "Language",
                value: controller.selectedLanguage.value,
                items: controller.languageOptions,
                onChanged: (val) {
                  if (val != null) controller.selectedLanguage.value = val;
                },
              )),
            ],
          ),
          const SizedBox(height: 20),

          _buildSectionCard(
            context,
            title:TextString.settingNotificationTitle ,
            subtitle:TextString.settingNotificationSubtitle ,
            children: [
              Obx(() => _buildSwitchTile(
                context,
                title:TextString.settingNotificationSound ,
                value: controller.notificationSound.value,
                onChanged: (val) => controller.notificationSound.value = val,
              )),
              _buildCustomDivider(),
              Obx(() => _buildSwitchTile(
                context,
                title:TextString.settingNotificationTrackingStarted,
                value: controller.trackingStarted.value,
                onChanged: (val) => controller.trackingStarted.value = val,
              )),
              _buildCustomDivider(),
              Obx(() => _buildSwitchTile(
                context,
                title:TextString.settingNotificationTrackingEnd ,
                value: controller.trackingStopped.value,
                onChanged: (val) => controller.trackingStopped.value = val,
              )),
              _buildCustomDivider(),
              Obx(() => _buildSwitchTile(
                context,
                title: TextString.settingIdle,
                value: controller.idleTimeWarning.value,
                onChanged: (val) => controller.idleTimeWarning.value = val,
              )),
              _buildCustomDivider(),
              Obx(() => _buildSwitchTile(
                context,
                title:TextString.settingSynchronization ,
                value: controller.synchronizationCompleted.value,
                onChanged: (val) => controller.synchronizationCompleted.value = val,
              )),
              _buildCustomDivider(),
              Obx(() => _buildSwitchTile(
                context,
                title:TextString.settingSystem ,
                value: controller.systemAnnouncement.value,
                onChanged: (val) => controller.systemAnnouncement.value = val,
              )),
            ],
          ),
        ],
      ),
    );
  }

  /// --------- Extra Widget -----------///

  // Divider
  Widget _buildCustomDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.borderColor,
      ),
    );
  }

  // CARD WRAPPER
  Widget _buildSectionCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required List<Widget> children,
      }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TTextTheme.titleEight(context)),
                const SizedBox(height: 4),
                Text(subtitle, style: TTextTheme.titleSix(context)),
              ],
            ),
          ),
          _buildCustomDivider(),
          ...children,
        ],
      ),
    );
  }

   // Switch Tile
  Widget _buildSwitchTile(
      BuildContext context, {
        required String title,
        String? subtitle,
        required bool value,
        required ValueChanged<bool> onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TTextTheme.titleEight(context)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle, style: TTextTheme.titleFour(context)),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            activeThumbColor: AppColors.whiteColor,
            activeTrackColor: AppColors.primaryColor,
            inactiveThumbColor: AppColors.whiteColor,
            inactiveTrackColor: AppColors.borderColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Dropdown Row Tile
  Widget _buildDropdownTile(
      BuildContext context, {
        required String title,
        required String value,
        required List<String> items,
        required ValueChanged<String?> onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 400;

          if (isSmallScreen) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TTextTheme.titleEight(context)),
                const SizedBox(height: 8),
                _buildDropdownButton(context, value, items, onChanged),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: TTextTheme.titleEight(context)),
              ),
              _buildDropdownButton(context, value, items, onChanged),
            ],
          );
        },
      ),
    );
  }

  // Dropdown Button Component
  Widget _buildDropdownButton(
      BuildContext context,
      String value,
      List<String> items,
      ValueChanged<String?> onChanged,
      ) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textColor),
          style: TTextTheme.titleMedium13(context),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ),
    );
  }
}
