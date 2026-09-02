import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.label,
    required this.color,
    this.fullWidth = false,
    this.soft = false,
  });

  final String label;
  final Color color;
  final bool fullWidth;
  final bool soft;

  factory AppStatusChip.order(OrderStatus status) =>
      AppStatusChip(label: status.label, color: status.chipColor);

  factory AppStatusChip.presence(PresenceStatus status) =>
      AppStatusChip(label: status.label, color: status.chipColor, soft: true);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.caption(context).copyWith(
      fontWeight: FontWeight.w600,
      color: soft ? color : AppColors.white,
    );

    return Container(
      width: fullWidth ? double.infinity : null,
      padding: AppSpacing.symmetric(context, h: 0.012, v: 0.004),
      decoration: BoxDecoration(
        color: soft ? color.withValues(alpha: 0.12) : color,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context, factor: 0.5)),
      ),
      child: Text(
        label,
        textAlign: fullWidth ? TextAlign.center : TextAlign.start,
        style: textStyle,
      ),
    );
  }
}
