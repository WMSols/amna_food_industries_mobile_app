import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';

/// Body shell under a primary AppBar.
///
/// Optional [header] sits in the primary band; the white content sheet
/// starts with a rounded top edge just below that header.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.header,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget body;
  final Widget? header;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final sheetRadius = AppResponsive.radius(context, factor: 5);

    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            Padding(
              padding: AppSpacing.screenPadding(context).copyWith(
                top: AppSpacing.verticalValue(context, 0.004),
                bottom: AppSpacing.verticalValue(context, 0.022),
              ),
              child: header,
            ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackground,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(sheetRadius),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: SafeArea(top: false, child: body),
            ),
          ),
        ],
      ),
    );
  }
}
