import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';

/// Leading icon with a single text value (amount, date, etc.).
class AppIconText extends StatelessWidget {
  const AppIconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = AppColors.grey,
    this.textColor = AppColors.textPrimary,
    this.textStyle,
    this.iconFactor = 0.85,
    this.expanded = false,
    this.maxLines = 1,
    this.textAlign,
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  final TextStyle? textStyle;
  final double iconFactor;
  final bool expanded;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final style = (textStyle ?? AppTextStyles.caption(context)).copyWith(
      color: textColor,
    );

    final label = Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );

    return Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AppResponsive.iconSize(context, factor: iconFactor),
          color: iconColor,
        ),
        AppSpacing.horizontal(context, 0.015),
        if (expanded) Expanded(child: label) else Flexible(child: label),
      ],
    );
  }
}
