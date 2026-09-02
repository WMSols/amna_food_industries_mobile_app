import 'package:amna_food_industries_mobile_app/core/network/api_map.dart';

class AppHelper {
  AppHelper._();

  static DateTime? parseDateTimeOrNull(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return ApiMap.asDateTime(value.trim());
  }

  static bool isNullOrEmpty(String? value) =>
      value == null || value.trim().isEmpty;

  static String initialsFromName(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
