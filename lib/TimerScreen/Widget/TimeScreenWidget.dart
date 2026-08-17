import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_app/Resources/Colors.dart';
import 'package:web_app/Resources/TextString.dart';
import 'package:web_app/Resources/TextTheme.dart';
import 'package:web_app/TimerScreen/TimerScreenController.dart';


class TimerScreenWidget extends StatelessWidget {
  const TimerScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimerScreenController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.timerScreenTitle,
            style: TTextTheme.h1Style(context),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.timerScreenSubtitler,
            style: TTextTheme.titleSix(context),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              children: [
                Text(
                  TextString.timerTracked,
                  style: TTextTheme.titleSix(context),
                ),
                const SizedBox(height: 8),
                Obx(
                      () => Text(
                    controller.formattedTime,
                    style: TTextTheme.h1Style(context),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                      () => OutlinedButton.icon(
                    onPressed: () => controller.toggleTimer(),
                    icon: Icon(
                      controller.isRunning.value
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                    label: Text(
                      controller.isRunning.value ? "Pause Timer" : "Start Timer",
                      style: TTextTheme.CancelBtn(context),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 650;
              final stats = [
                _StatData(
                  icon: Icons.access_time_rounded,
                  iconColor: AppColors.approvedColor,
                  title: TextString.timerKPiOne,
                  value: TextString.timerKPiTwo ,
                  subTitle:TextString.timerKPiThree ,
                ),
                _StatData(
                  icon: Icons.access_time_rounded,
                  iconColor: AppColors.rejectedColor,
                  title:TextString.timerKPiFour ,
                  value:TextString.timerKPiFive ,
                  subTitle:TextString.timerKPiSix ,
                ),
                _StatData(
                  icon: Icons.trending_up_rounded,
                  iconColor: AppColors.primaryColor,
                  title:TextString.timerKPiSeven ,
                  value:TextString.timerKPiEight ,
                  subTitle:TextString.timerKPiNine ,
                ),
              ];

              if (isMobile) {
                return Column(
                  children: stats
                      .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildStatCard(context, item),
                  ))
                      .toList(),
                );
              }

              return Row(
                children: stats
                    .map((item) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _buildStatCard(context, item),
                  ),
                ))
                    .toList(),
              );
            },
          ),

          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.timerActivityMonitoring,
                  style: TTextTheme.h2Style(context),
                ),
                const SizedBox(height: 4),
                Text(
                  TextString.timerActivityMonitoringSubtitle,
                  style: TTextTheme.titleSix(context),
                ),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 650;
                    final leftFeatures = [
                      _FeatureData(TextString.timerActivityOne,TextString.timerActivityTwo ),
                      _FeatureData(TextString.timerActivityThree,TextString.timerActivityFour ),
                      _FeatureData(TextString.timerActivityFive,TextString.timerActivitySix ),
                    ];
                    final rightFeatures = [
                      _FeatureData(TextString.timerActivitySeven,TextString.timerActivityEight ),
                      _FeatureData(TextString.timerActivityNine,TextString.timerActivityTen ),
                      _FeatureData(TextString.timerActivityEleven,TextString.timerActivityTwelve ),
                    ];

                    if (isMobile) {
                      return Column(
                        children: [...leftFeatures, ...rightFeatures]
                            .map((f) => _buildFeatureItem(context, f.title, f.desc))
                            .toList(),
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: leftFeatures
                                .map((f) => _buildFeatureItem(context, f.title, f.desc))
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: rightFeatures
                                .map((f) => _buildFeatureItem(context, f.title, f.desc))
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// --------- Extra Widget --------------///

   // Stat Card
  Widget _buildStatCard(BuildContext context, _StatData item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(item.icon, size: 18, color: item.iconColor),
              const SizedBox(width: 8),
              Text(
                item.title,
                style: TTextTheme.titleFour(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.value,
            style: TTextTheme.h2Style(context),
          ),
          const SizedBox(height: 6),
          Text(
            item.subTitle,
            style: TTextTheme.titleRegular11(context),
          ),
        ],
      ),
    );
  }

   // Feature Item
  Widget _buildFeatureItem(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: AppColors.approvedColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 12,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TTextTheme.titleEight(context),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TTextTheme.titleFour(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 /// -------- Extra Class ----------- ///

 // stat Data class
class _StatData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subTitle;

  _StatData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subTitle,
  });
}


 // Feature Data class
class _FeatureData {
  final String title;
  final String desc;

  _FeatureData(this.title, this.desc);
}
