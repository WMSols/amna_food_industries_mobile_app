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

  /// Soft style: tinted background + colored text (vs solid fill + white text).
  final bool soft;

  factory AppStatusChip.order(OrderStatus status, {bool soft = false}) =>
      AppStatusChip(label: status.label, color: status.chipColor, soft: soft);

  factory AppStatusChip.presence(PresenceStatus status) =>
      AppStatusChip(label: status.label, color: status.chipColor);

  factory AppStatusChip.fullWidth({
    required String label,
    required Color color,
  }) => AppStatusChip(label: label, color: color, fullWidth: true);

  @override
  Widget build(BuildContext context) {
    final background = soft ? color.withValues(alpha: 0.2) : color;
    final foreground = soft ? color : AppColors.white;

    final child = Container(
      width: fullWidth ? double.infinity : null,
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.002),
      alignment: fullWidth ? Alignment.center : null,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context) * 0.5,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        textAlign: fullWidth ? TextAlign.center : TextAlign.start,
        style: AppTextStyles.hintText(
          context,
        ).copyWith(color: foreground, fontWeight: FontWeight.w600),
      ),
    );

    if (!fullWidth) return child;
    return SizedBox(width: double.infinity, child: child);
  }
}
