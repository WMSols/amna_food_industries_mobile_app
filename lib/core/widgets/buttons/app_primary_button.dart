import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.labelStyle,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary;
    final fg = foregroundColor ?? AppColors.white;

    return SizedBox(
      width: double.infinity,
      height: AppResponsive.scaleSize(context, 40),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          disabledBackgroundColor: bg.withValues(alpha: 0.7),
          foregroundColor: fg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: AppResponsive.buttonLoaderSize(context, factor: 0.3),
                height: AppResponsive.buttonLoaderSize(context, factor: 0.3),
                child: CircularProgressIndicator(strokeWidth: 2, color: fg),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: fg,
                      size: AppResponsive.scaleSize(context, 18),
                    ),
                    SizedBox(width: AppResponsive.scaleSize(context, 8)),
                  ],
                  Text(
                    label,
                    style: (labelStyle ?? AppTextStyles.buttonText(context))
                        .copyWith(color: fg),
                  ),
                ],
              ),
      ),
    );
  }
}
