import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/Resources/AppSizes.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:web_app/Resources/IconString.dart';
import 'package:web_app/Resources/TextString.dart';
import 'package:web_app/Resources/TextTheme.dart';
import 'package:web_app/SidebarScreen/SidebarWebController.dart';
import 'package:web_app/SidebarScreen/Widget/MobileVendorAppbar.dart';
import 'package:web_app/SidebarScreen/Widget/WebHeaderWidget.dart';


class SidebarWebScreen extends StatelessWidget {
  final Function(String) onTap;
  final Widget? child;

  SidebarWebScreen({
    super.key,
    required this.onTap,
    this.child,
  }) {
    Get.lazyPut<SidebarWebController>(() => SidebarWebController(), fenix: true);
  }

  final SidebarWebController controller = Get.put(SidebarWebController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool isTab = AppSizes.isTablet(context);
    final String currentRoute = GoRouterState.of(context).uri.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.syncWithRoute(currentRoute);
    });

    Widget buildMobileDrawer() {
      return Container(
        color: AppColors.whiteColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      IconString.logoIcon,
                      height: 28,
                      width: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      TextString.sidebarLogoText,
                      style: TTextTheme.hLogoName(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                      () => ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: [
                      _buildDrawerItem(
                        context,
                        title: "Timer",
                        onTap: () {
                          controller.selectMenu("Timer");
                          Navigator.pop(context);
                          context.go('/timer');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        title: "Notification",
                        badgeCount: controller.notificationCount.value.toString(),
                        onTap: () {
                          controller.selectMenu("Notification");
                          Navigator.pop(context);
                          context.go('/notifications');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        title: "Settings",
                        onTap: () {
                          controller.selectMenu("Settings");
                          Navigator.pop(context);
                          context.go('/settings');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        title: "Help Center",
                        onTap: () {
                          controller.selectMenu("Help Center");
                          Navigator.pop(context);
                          context.go('/help');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (isMobile || isTab) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          child: buildMobileDrawer(),
        ),
        appBar: MobileVendorHeaderAppbar(
          onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        body: child,
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            const WebVendorHeaderAppbar(),
            Expanded(child: child ?? const SizedBox.shrink()),
          ],
        ),
      );
    }
  }

   /// ----------- Extra Widget --------------///

    // Drawer Item
  Widget _buildDrawerItem(
      BuildContext context, {
        required String title,
        String? badgeCount,
        required VoidCallback onTap,
      }) {
    final bool isSelected = controller.selected.value == title;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: isSelected
                ? TTextTheme.pSelectedSidebar(context).copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w400,
            )
                : TTextTheme.pSidebar(context).copyWith(
              color: AppColors.textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: badgeCount != null
              ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              badgeCount,
              style: TTextTheme.btnTextOne(context).copyWith(
                fontSize: 10,
                color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
              : null,
        ),
      ),
    );
  }
}