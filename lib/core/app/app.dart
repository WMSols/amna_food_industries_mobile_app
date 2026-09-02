import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/bindings/initial_binding.dart';
import 'package:amna_food_industries_mobile_app/core/design/system/app_system_ui.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/design/theme/app_theme.dart';
import 'package:amna_food_industries_mobile_app/core/localization/app_translations.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_pages.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_top_feedback_overlay.dart';

class AmnaFoodApp extends StatelessWidget {
  const AmnaFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppTexts.appName,
      theme: AppTheme.light,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.overlayStyle,
          child: Stack(
            fit: StackFit.expand,
            children: [
              child ?? const SizedBox.shrink(),
              const AppTopFeedbackOverlay(),
            ],
          ),
        );
      },
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
