import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';

enum AppEdgeIconButtonSide { left, right }

/// White icon tab flush to a screen edge.
///
/// - [AppEdgeIconButtonSide.right]: rounded top/bottom left only
/// - [AppEdgeIconButtonSide.left]: rounded top/bottom right only
class AppEdgeIconButton extends StatelessWidget {
  const AppEdgeIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.side = AppEdgeIconButtonSide.right,
    this.iconColor = AppColors.primary,
    this.backgroundColor = AppColors.white,
    this.iconFactor = 1.35,
    this.radiusFactor = 3,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final AppEdgeIconButtonSide side;
  final Color iconColor;
  final Color backgroundColor;
  final double iconFactor;
  final double radiusFactor;

  bool get _isLeft => side == AppEdgeIconButtonSide.left;

  @override
  Widget build(BuildContext context) {
    final radius = AppResponsive.radius(context, factor: radiusFactor);
    final iconSize = AppResponsive.iconSize(context, factor: iconFactor);
    final shape = BorderRadius.only(
      topLeft: _isLeft ? Radius.zero : Radius.circular(radius),
      bottomLeft: _isLeft ? Radius.zero : Radius.circular(radius),
      topRight: _isLeft ? Radius.circular(radius) : Radius.zero,
      bottomRight: _isLeft ? Radius.circular(radius) : Radius.zero,
    );

    final edgePad = AppSpacing.horizontalValue(context, 0.04);
    final innerPad = AppSpacing.horizontalValue(context, 0.035);
    final verticalPad = AppSpacing.verticalValue(context, 0.008);

    return Align(
      alignment: _isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Material(
        color: backgroundColor,
        borderRadius: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: shape,
          child: Padding(
            padding: EdgeInsets.only(
              left: _isLeft ? edgePad : innerPad,
              right: _isLeft ? innerPad : edgePad,
              top: verticalPad,
              bottom: verticalPad,
            ),
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
        ),
      ),
    );
  }
}
