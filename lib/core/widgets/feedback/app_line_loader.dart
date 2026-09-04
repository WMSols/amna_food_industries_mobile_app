import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';

/// Thin top-edge linear progress indicator for in-place refresh / sync.
class AppLineLoader extends StatelessWidget {
  const AppLineLoader({
    super.key,
    this.height = 2,
    this.color = AppColors.primary,
    this.backgroundColor = Colors.transparent,
  });

  final double height;
  final Color color;
  final Color backgroundColor;

  /// Shows [AppLineLoader] pinned to the top of [child] when [loading] is true.
  static Widget overlay({
    required Widget child,
    required bool loading,
    double height = 2,
    Color color = AppColors.primary,
    Color backgroundColor = Colors.transparent,
  }) {
    if (!loading) return child;
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppLineLoader(
            height: height,
            color: color,
            backgroundColor: backgroundColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: height,
      color: color,
      backgroundColor: backgroundColor,
    );
  }
}
