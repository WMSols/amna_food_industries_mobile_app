import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';

/// Title + optional subtitle with a trailing widget (e.g. status chip).
class AppCardHeader extends StatelessWidget {
  const AppCardHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleMaxLines = 2,
    this.subtitleColor = AppColors.darkGrey,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final int titleMaxLines;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    final subtitleText = subtitle?.trim();
    final hasSubtitle = subtitleText != null && subtitleText.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.sectionTitle(context),
                maxLines: titleMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
              if (hasSubtitle) ...[
                AppSpacing.vertical(context, 0.004),
                Text(
                  subtitleText,
                  style: AppTextStyles.bodyText(
                    context,
                  ).copyWith(color: subtitleColor, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          AppSpacing.horizontal(context, 0.02),
          trailing!,
        ],
      ],
    );
  }
}
