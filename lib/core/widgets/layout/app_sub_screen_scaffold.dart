import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/icons/app_icons.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/buttons/app_edge_icon_button.dart';

class AppSubScreenScaffold extends StatelessWidget {
  const AppSubScreenScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final sheetRadius = AppResponsive.radius(context, factor: 5);

    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: AppResponsive.scaleSize(context, 72),
        leading: AppEdgeIconButton(
          side: AppEdgeIconButtonSide.left,
          icon: AppIcons.back,
          onTap: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          title,
          style: AppTextStyles.heading(
            context,
          ).copyWith(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: AppSpacing.screenPadding(
          context,
        ).copyWith(left: 0, right: 0, bottom: 0),
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
      floatingActionButton: floatingActionButton,
    );
  }
}
