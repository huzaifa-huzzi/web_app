import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:web_app/Resources/TextString.dart';
import 'package:web_app/Resources/TextTheme.dart';
import 'package:web_app/SidebarScreen/SidebarWebController.dart';

class MobileVendorHeaderAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;
  final VoidCallback? onDashboardTap;
  final VoidCallback? onSignOutTap;

  const MobileVendorHeaderAppbar({
    super.key,
    required this.onMenuTap,
    this.onDashboardTap,
    this.onSignOutTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SidebarWebController>();

    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.whiteColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: AppColors.borderColor.withValues(alpha: 0.6),
          height: 1,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            InkWell(
              onTap: onMenuTap,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.menu_rounded,
                  size: 26,
                  color: AppColors.textColor,
                ),
              ),
            ),

            const Spacer(),
            ElevatedButton.icon(
              onPressed: onDashboardTap ?? () => context.go('/timer'),
              icon: const Icon(
                Icons.explore_outlined,
                size: 15,
                color: AppColors.whiteColor,
              ),
              label: Text(
                "Dashboard",
                style: TTextTheme.btnTextOne(context).copyWith(fontSize: 11),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            const SizedBox(width: 6),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.rejectedColor, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: onSignOutTap ?? () => controller.signOut(context),
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 16,
                  color: AppColors.rejectedColor,
                ),
                tooltip: TextString.signOutText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

