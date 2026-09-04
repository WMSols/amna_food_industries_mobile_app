import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/utils/helper/app_helper.dart';

class AppProfileAvatar extends StatelessWidget {
  const AppProfileAvatar({
    super.key,
    this.size = 48,
    this.onTap,
    this.name = '',
    this.presenceStatus,
    this.showPresenceDot = false,
    this.onPrimary = false,
  });

  final double size;
  final VoidCallback? onTap;
  final String name;
  final PresenceStatus? presenceStatus;
  final bool showPresenceDot;

  /// Light circle + primary initials for use on primary surfaces
  /// (AppBar / [AppScaffold] header band).
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    final resolvedSize = AppResponsive.scaleSize(context, size);
    final initials = AppHelper.initialsFromName(name);
    final dotSize = (resolvedSize * 0.28).clamp(8.0, 16.0);
    final fill = onPrimary ? AppColors.white : AppColors.primary;
    final foreground = onPrimary ? AppColors.primary : AppColors.white;
    final dotBorder = onPrimary ? AppColors.primary : AppColors.white;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: resolvedSize,
        height: resolvedSize,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: resolvedSize,
              height: resolvedSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fill,
                border: onPrimary
                    ? Border.all(
                        color: AppColors.white.withValues(alpha: 0.45),
                        width: 1.5,
                      )
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: AppTextStyles.sectionTitle(context).copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                  fontSize: resolvedSize * 0.36,
                ),
              ),
            ),
            if (showPresenceDot && presenceStatus != null)
              Positioned(
                right: 5,
                bottom: 0,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: presenceStatus!.chipColor,
                    border: Border.all(color: dotBorder, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
