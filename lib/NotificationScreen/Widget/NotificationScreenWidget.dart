import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:web_app/NotificationScreen/NotificationController.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:web_app/Resources/IconString.dart';
import 'package:web_app/Resources/TextString.dart';
import 'package:web_app/Resources/TextTheme.dart';



class NotificationScreenWidget extends StatelessWidget {
  const NotificationScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.notificationTitle,
            style: TTextTheme.h1Style(context),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.notificationSubtitle,
            style: TTextTheme.titleSix(context),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 600;
                    if (isMobile) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              _buildTabButtons(context, controller),
                              const SizedBox(width: 8),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildSearchField(context, controller),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTabButtons(context, controller),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 280,
                          child: _buildSearchField(context, controller),
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Obx(() {
                  final list = controller.filteredNotifications;
                  if (list.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        TextString.notificationErrorText,
                        style: TTextTheme.TextError(context),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(context, list[index]);
                    },
                  );
                }),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                          () => IconButton(
                        onPressed: controller.currentPage.value > 1
                            ? () => controller.previousPage()
                            : null,
                        icon: const Icon(Icons.arrow_back, size: 18),
                        style: IconButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.borderColor.withValues(alpha: 0.5),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                          () => Text(
                        "Page ${controller.currentPage.value} of ${controller.totalPages}",
                        style: TTextTheme.titleMedium13(context),
                      ),
                    ),
                    Obx(
                          () => IconButton(
                        onPressed: controller.currentPage.value < controller.totalPages
                            ? () => controller.nextPage()
                            : null,
                        icon: const Icon(Icons.arrow_forward, size: 18),
                        style: IconButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.borderColor.withValues(alpha: 0.5),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// --------- Extra Widget -------------///

  // Tab Buttons
  Widget _buildTabButtons(BuildContext context, NotificationController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(3),
      child: Obx(
            () => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTabItem(context, controller,TextString.notificationTabOne),
            _buildTabItem(context, controller,TextString.notificationTabTwo ),
          ],
        ),
      ),
    );
  }

   // Tab Item
  Widget _buildTabItem(BuildContext context, NotificationController controller, String label) {
    bool isSelected = controller.selectedTab.value == label;
    return GestureDetector(
      onTap: () => controller.selectedTab.value = label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: isSelected
              ? TTextTheme.TabsSelectedText(context)
              : TTextTheme.titleSix(context),
        ),
      ),
    );
  }

  // SEARCH FIELD
  Widget _buildSearchField(BuildContext context, NotificationController controller) {
    return SizedBox(
      height: 38,
      child: TextField(
        cursorColor: AppColors.textColor,
        onChanged: (val) => controller.searchQuery.value = val,
        style: TTextTheme.FieldWriteTheText(context),
        decoration: InputDecoration(
          hintText: TextString.notificationFieldText,
          hintStyle: TTextTheme.selectProjectText(context),
          prefixIcon: const Icon(Icons.filter_list, size: 18, color: AppColors.tertiaryTextColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          filled: true,
          fillColor: AppColors.backgroundOfScreenColor.withValues(alpha: 0.5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  // item Car Builder
  Widget _buildNotificationCard(BuildContext context, NotificationModel item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.4)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isVerySmall = constraints.maxWidth < 320;

          if (isVerySmall) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _getNotificationIcon(item.type),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.title,
                        style: TTextTheme.titleEight(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TTextTheme.titleFour(context),
                ),
                const SizedBox(height: 6),
                Text(
                  item.time,
                  style: TTextTheme.ForgotPasswordText(context),
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getNotificationIcon(item.type),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TTextTheme.titleEight(context),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: TTextTheme.titleFour(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.time,
                style: TTextTheme.ForgotPasswordText(context),
              ),
            ],
          );
        },
      ),
    );
  }

  // ICON & COLOR MAPPING
  Widget _getNotificationIcon(String type) {
    switch (type) {
      case 'started':
        return Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 3),
          decoration: const BoxDecoration(
            color: AppColors.approvedColor,
            shape: BoxShape.circle,
          ),
        );
      case 'stopped':
        return Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 3),
          decoration: const BoxDecoration(
            color: AppColors.rejectedColor,
            shape: BoxShape.circle,
          ),
        );
      case 'warning':
        return Padding(
          padding: const EdgeInsets.only(top: 1),
          child: SvgPicture.asset(
            IconString.idleWarning,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.rejectedColor,
              BlendMode.srcIn,
            ),
          ),
        );
      case 'synced':
        return Padding(
          padding: const EdgeInsets.only(top: 1),
          child: SvgPicture.asset(
            IconString.dataSynced,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        );
      case 'screenshot':
        return Padding(
          padding: const EdgeInsets.only(top: 1),
          child: SvgPicture.asset(
            IconString.screenshotNotification,
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
