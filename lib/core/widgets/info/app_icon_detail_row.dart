import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';

/// Compact icon + labeled value row for cards and summary blocks.
///
/// Example: `Ref: MOBILE` or `Notes: Call before delivery`.
class AppIconDetailRow extends StatelessWidget {
  const AppIconDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = AppColors.grey,
    this.textColor = AppColors.darkGrey,
    this.maxLines = 1,
    this.iconFactor = 0.8,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color textColor;
  final int maxLines;
  final double iconFactor;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.caption(context).copyWith(color: textColor);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: AppResponsive.iconSize(context, factor: iconFactor),
          color: iconColor,
        ),
        AppSpacing.horizontal(context, 0.015),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: style.copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value, style: style),
              ],
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
