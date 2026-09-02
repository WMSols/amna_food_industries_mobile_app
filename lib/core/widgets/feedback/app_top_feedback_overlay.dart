import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_toast.dart';

class AppTopFeedbackOverlay extends StatelessWidget {
  const AppTopFeedbackOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Observe overlay epoch so rebuilds happen when toast state changes.
      final _ = AppToast.overlayEpoch;
      final visible = AppToast.isVisible;
      return SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: AppSlideInBar(
            visible: visible,
            onExitComplete: AppToast.completeClose,
            child: AppToastBar(
              message: AppToast.toastMessage,
              style: AppToast.toastStyle,
              showClose: AppToast.toastShowClose,
              onClose: AppToast.close,
              onSwipeDismissed: AppToast.completeClose,
            ),
          ),
        ),
      );
    });
  }
}
