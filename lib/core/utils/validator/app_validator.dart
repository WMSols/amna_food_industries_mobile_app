import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/utils/helper/app_helper.dart';

class AppValidator {
  AppValidator._();

  static String? validateRequired(String? value, [String? fieldName]) {
    if (AppHelper.isNullOrEmpty(value)) {
      return fieldName != null
          ? '$fieldName is required'
          : AppTexts.fieldRequired;
    }
    return null;
  }

  static String? validatePasswordLogin(String? value) {
    if (AppHelper.isNullOrEmpty(value)) return AppTexts.fieldRequired;
    return null;
  }
}
