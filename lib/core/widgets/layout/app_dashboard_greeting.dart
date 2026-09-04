import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';

class AppDashboardGreeting extends StatelessWidget {
  const AppDashboardGreeting({
    super.key,
    required this.greeting,
    required this.userName,
    this.onPrimary = false,
  });

  final String greeting;
  final String userName;

  /// When true, uses light text for a primary-colored header band.
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    final subtitleColor = onPrimary
        ? AppColors.white.withValues(alpha: 0.85)
        : AppColors.grey;
    final titleColor = onPrimary ? AppColors.white : AppColors.textPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: AppTextStyles.bodyText(context).copyWith(color: subtitleColor),
        ),
        Text(
          '${AppTexts.dashboardWelcome}, $userName',
          style: AppTextStyles.sectionTitle(
            context,
          ).copyWith(color: titleColor),
        ),
      ],
    );
  }
}
