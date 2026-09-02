import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppResponsive.scaleSize(context, 40),
            height: AppResponsive.scaleSize(context, 40),
            child: const CircularProgressIndicator(
              strokeWidth: 5,
              color: AppColors.primary,
            ),
          ),
          if (message != null) ...[
            AppSpacing.vertical(context, 0.01),
            Text(message!, style: AppTextStyles.hintText(context)),
          ],
        ],
      ),
    );
  }
}
