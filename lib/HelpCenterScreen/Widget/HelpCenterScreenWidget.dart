import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/HelpCenterScreen/HelpCenterController.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:web_app/Resources/TextString.dart';
import 'package:web_app/Resources/TextTheme.dart';

class HelpCenterScreenWidget extends StatelessWidget {
  const HelpCenterScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HelpCenterController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.helpCenterTitle,
            style: TTextTheme.h1Style(context),
          ),
          const SizedBox(height: 4),
          Text(
           TextString.helpCenterSubtitle,
            style: TTextTheme.titleSix(context),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.helpCenterFaqTitle,
                  style: TTextTheme.titleEight(context).copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  TextString.helpCenterFaqSubtitle,
                  style: TTextTheme.titleSix(context),
                ),
                const SizedBox(height: 20),
                Obx(
                      () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.faqs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildFAQCardItem(context, controller.faqs[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ----------- Extra Widget ----------- ///

  // Faq Item Card
  Widget _buildFAQCardItem(BuildContext context, FAQItem item) {
    return Obx(
          () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: InkWell(
          onTap: () => item.isExpanded.value = !item.isExpanded.value,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.question,
                      style: TTextTheme.titleEight(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // CIRCULAR ARROW BUTTON
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.textColor.withValues(alpha: 0.6)),
                    ),
                    child: Icon(
                      item.isExpanded.value
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              if (item.isExpanded.value) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: Text(
                    item.answer,
                    style: TTextTheme.titleFour(context),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}