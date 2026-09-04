import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/services/connectivity_service.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_toast.dart';

/// Sticky offline banner + transient toasts, pinned under the status bar.
///
/// Must be [Positioned] at the top of the app [Stack] — without that, the
/// overlay expands to the full screen and success/info bars look full-bleed.
class AppTopFeedbackOverlay extends StatelessWidget {
  const AppTopFeedbackOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final _ = AppToast.overlayEpoch;
      final offline =
          Get.isRegistered<ConnectivityService>() &&
          !Get.find<ConnectivityService>().isOnline.value;
      final hasToast = AppToast.hasToast;

      return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSlideInBar(
                visible: offline,
                child: AppToastBar(
                  message: AppTexts.noInternet,
                  style: AppToastStyle.error,
                ),
              ),
              AppSlideInBar(
                key: ValueKey('app-toast-slide-${AppToast.toastToken}'),
                visible: AppToast.isVisible,
                onExitComplete: AppToast.completeClose,
                child: hasToast
                    ? AppToastBar(
                        key: ValueKey('app-toast-${AppToast.toastToken}'),
                        message: AppToast.toastMessage,
                        style: AppToast.toastStyle,
                        showClose: AppToast.toastShowClose,
                        onClose: AppToast.close,
                        onSwipeDismissed: AppToast.completeClose,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
