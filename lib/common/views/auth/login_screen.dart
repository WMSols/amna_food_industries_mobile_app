import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/common/widgets/auth/app_auth_primary_panel.dart';
import 'package:amna_food_industries_mobile_app/common/widgets/auth/auth_corner_accents.dart';
import 'package:amna_food_industries_mobile_app/common/widgets/auth/auth_header_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthHeaderSection(),
                AppSpacing.vertical(context, 0.02),
                AppAuthPrimaryPanel(),
              ],
            ),
          ),
          // Fixed to full-screen size; ignore keyboard resize.
          const AuthCornerAccents(),
        ],
      ),
    );
  }
}
