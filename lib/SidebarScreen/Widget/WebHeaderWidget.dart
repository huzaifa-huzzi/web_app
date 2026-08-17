import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:web_app/Resources/IconString.dart';
import 'package:web_app/Resources/TextString.dart';
import 'package:web_app/Resources/TextTheme.dart';
import 'package:web_app/SidebarScreen/SidebarWebController.dart';


class WebVendorHeaderAppbar extends StatelessWidget {
  final VoidCallback? onDashboardTap;
  final VoidCallback? onSignOutTap;

  const WebVendorHeaderAppbar({
    super.key,
    this.onDashboardTap,
    this.onSignOutTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SidebarWebController>();

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                IconString.logoIcon,
                height: 28,
                width: 28,
              ),
              const SizedBox(width: 10),
              Text(
                TextString.sidebarLogoText,
                style: TTextTheme.hLogoName(context),
              ),
            ],
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeaderLink(
                      context,
                      title: "Timer",
                      isSelected: controller.selected.value == "Timer",
                      onTap: () {
                        controller.selectMenu("Timer");
                        context.go('/timer');
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildHeaderLinkWithBadge(
                      context,
                      title: "Notification",
                      badgeCount: controller.notificationCount.value.toString(),
                      isSelected: controller.selected.value == "Notification",
                      onTap: () {
                        controller.selectMenu("Notification");
                        context.go('/notifications');
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildHeaderLink(
                      context,
                      title: "Settings",
                      isSelected: controller.selected.value == "Settings",
                      onTap: () {
                        controller.selectMenu("Settings");
                        context.go('/settings');
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildHeaderLink(
                      context,
                      title: "Help Center",
                      isSelected: controller.selected.value == "Help Center",
                      onTap: () {
                        controller.selectMenu("Help Center");
                        context.go('/help');
                      },
                    ),
                  ],
                )),
              ),
            ),
          ),

          const SizedBox(width: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: onDashboardTap ?? () => context.go('/timer'),
                icon: const Icon(
                  Icons.explore_outlined,
                  size: 15,
                  color: AppColors.whiteColor,
                ),
                label: Text(
                  "Open Dashboard",
                  style: TTextTheme.btnTextOne(context).copyWith(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              OutlinedButton.icon(
                onPressed: onSignOutTap ?? () => controller.signOut(context),
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 15,
                  color: AppColors.rejectedColor,
                ),
                label: Text(
                  TextString.signOutText,
                  style: TTextTheme.signoutIconText(context).copyWith(
                    fontSize: 12,
                    color: AppColors.rejectedColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.rejectedColor, width: 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

   /// ----------- Extra Widget -----------///

   // Header link
  Widget _buildHeaderLink(
      BuildContext context, {
        required String title,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(
        title,
        style: isSelected
            ? TTextTheme.pSelectedSidebar(context).copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w400,
        )
            : TTextTheme.pSidebar(context).copyWith(
          color: AppColors.textColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

   // header link with badge
  Widget _buildHeaderLinkWithBadge(
      BuildContext context, {
        required String title,
        required String badgeCount,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: isSelected
                ? TTextTheme.pSelectedSidebar(context).copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
            )
                : TTextTheme.pSidebar(context).copyWith(
              color: AppColors.textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: const BoxDecoration(
              color: AppColors.rejectedColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              badgeCount,
              style: TTextTheme.btnTextOne(context).copyWith(
                fontSize: 11,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}