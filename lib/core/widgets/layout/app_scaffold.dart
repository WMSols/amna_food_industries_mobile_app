import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget body;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(child: body),
    );
  }
}
