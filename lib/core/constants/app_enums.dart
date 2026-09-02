import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';

enum UserRole { orderBooker }

enum OrderStatus { draft, submitted, confirmed, delivered, cancelled }

enum PresenceStatus { online, away, offline }

extension UserRoleX on UserRole {
  String get label => switch (this) {
        UserRole.orderBooker => AppTexts.roleOrderBooker,
      };
}

extension OrderStatusX on OrderStatus {
  String get label => switch (this) {
        OrderStatus.draft => AppTexts.orderStatusDraft,
        OrderStatus.submitted => AppTexts.orderStatusSubmitted,
        OrderStatus.confirmed => AppTexts.orderStatusConfirmed,
        OrderStatus.delivered => AppTexts.orderStatusDelivered,
        OrderStatus.cancelled => AppTexts.orderStatusCancelled,
      };

  Color get chipColor => switch (this) {
        OrderStatus.delivered => AppColors.success,
        OrderStatus.submitted || OrderStatus.confirmed => AppColors.primary,
        OrderStatus.cancelled => AppColors.error,
        OrderStatus.draft => AppColors.textMuted,
      };
}

extension PresenceStatusX on PresenceStatus {
  String get label => switch (this) {
        PresenceStatus.online => AppTexts.statusOnline,
        PresenceStatus.away => AppTexts.statusAway,
        PresenceStatus.offline => AppTexts.statusOffline,
      };

  Color get chipColor => switch (this) {
        PresenceStatus.online => AppColors.success,
        PresenceStatus.away => AppColors.warning,
        PresenceStatus.offline => AppColors.textMuted,
      };

  static PresenceStatus fromApi(dynamic value) {
    final raw = value?.toString().trim().toLowerCase() ?? '';
    return PresenceStatus.values.firstWhere(
      (status) => status.name == raw,
      orElse: () => PresenceStatus.away,
    );
  }
}
