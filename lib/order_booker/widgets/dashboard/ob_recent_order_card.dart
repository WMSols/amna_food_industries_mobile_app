import 'package:flutter/material.dart';

import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/icons/app_icons.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/utils/formatter/app_formatter.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/cards/app_outline_card.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/chips/app_status_chip.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/info/app_card_header.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/info/app_icon_detail_row.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/info/app_icon_text.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/sales_order_draft.dart';

class ObRecentOrderCard extends StatelessWidget {
  const ObRecentOrderCard({super.key, required this.order});

  final SalesOrderSummary order;

  @override
  Widget build(BuildContext context) {
    final note = order.note?.trim();
    final ref = order.clientOrderRef?.trim();
    final hasNote = note != null && note.isNotEmpty;
    final hasRef = ref != null && ref.isNotEmpty;

    return AppOutlineCard(
      statusColor: order.status.chipColor,
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.016),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(
            title: order.customerName,
            subtitle: order.orderName,
            trailing: AppStatusChip(
              label: order.status.label,
              color: order.status.chipColor,
            ),
          ),
          AppSpacing.vertical(context, 0.01),
          Row(
            children: [
              Expanded(
                child: AppIconText(
                  icon: AppIcons.money,
                  text: AppFormatter.currency(order.total),
                  iconColor: AppColors.primary,
                  textColor: AppColors.primary,
                  textStyle: AppTextStyles.sectionTitle(context),
                  expanded: true,
                ),
              ),
              AppIconText(
                icon: AppIcons.calendar,
                text: AppFormatter.dateTimeShort(order.createdAt),
                iconColor: AppColors.grey,
                textColor: AppColors.grey,
                iconFactor: 0.8,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          if (hasNote || hasRef) ...[
            AppSpacing.vertical(context, 0.012),
            const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
            AppSpacing.vertical(context, 0.01),
            if (hasRef)
              AppIconDetailRow(
                icon: AppIcons.invoices,
                label: AppTexts.orderReference,
                value: ref,
              ),
            if (hasNote) ...[
              if (hasRef) AppSpacing.vertical(context, 0.008),
              AppIconDetailRow(
                icon: AppIcons.note,
                label: AppTexts.notes,
                value: note,
                maxLines: 3,
              ),
            ],
          ],
        ],
      ),
    );
  }
}
