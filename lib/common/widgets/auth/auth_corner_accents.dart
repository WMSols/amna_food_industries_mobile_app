import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';

/// Decorative rotated squircle layers for auth screens
/// (top-right primary, bottom-left secondary).
///
/// Sized to the full display (keyboard insets ignored) so accents do not
/// jump when the Scaffold resizes for the soft keyboard.
class AuthCornerAccents extends StatelessWidget {
  const AuthCornerAccents({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // Body height shrinks with the keyboard; restore full display size.
    final fullWidth = media.size.width;
    final fullHeight = media.size.height + media.viewInsets.bottom;
    final shapeSize = math.min(fullWidth, fullHeight) * 0.72;

    return IgnorePointer(
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minWidth: fullWidth,
        maxWidth: fullWidth,
        minHeight: fullHeight,
        maxHeight: fullHeight,
        child: SizedBox(
          width: fullWidth,
          height: fullHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -shapeSize * 0.1,
                right: -shapeSize * 0.5,
                child: _LayeredSquircle(
                  size: shapeSize,
                  front: AppColors.primary,
                  back: Color.alphaBlend(
                    AppColors.white.withValues(alpha: 0.45),
                    AppColors.primary,
                  ).withValues(alpha: 0.55),
                  backOffset: Offset(-shapeSize * 0.05, shapeSize * 0.05),
                ),
              ),
              Positioned(
                bottom: -shapeSize * 0.2,
                left: -shapeSize * 0.5,
                child: _LayeredSquircle(
                  size: shapeSize,
                  front: AppColors.secondary,
                  back: Color.alphaBlend(
                    AppColors.white.withValues(alpha: 0.45),
                    AppColors.secondary,
                  ).withValues(alpha: 0.55),
                  backOffset: Offset(shapeSize * 0.05, -shapeSize * 0.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LayeredSquircle extends StatelessWidget {
  const _LayeredSquircle({
    required this.size,
    required this.front,
    required this.back,
    required this.backOffset,
  });

  final double size;
  final Color front;
  final Color back;
  final Offset backOffset;

  @override
  Widget build(BuildContext context) {
    final tile = size * 0.62;

    Widget diamond(Color color) {
      return Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: tile,
          height: tile,
          decoration: BoxDecoration(color: color),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(offset: backOffset, child: diamond(back)),
          diamond(front),
        ],
      ),
    );
  }
}
