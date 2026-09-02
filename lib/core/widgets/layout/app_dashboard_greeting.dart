import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';

class AppDashboardGreeting extends StatelessWidget {
  const AppDashboardGreeting({
    super.key,
    required this.greeting,
    required this.userName,
  });

  final String greeting;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: AppTextStyles.bodyText(context).copyWith(color: AppColors.grey),
        ),
        Text(
          '${AppTexts.dashboardWelcome}, $userName',
          style: AppTextStyles.heading(context),
        ),
      ],
    );
  }
}
