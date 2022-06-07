import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slider_captcha/self.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/models/OperationalLogAction.dart';
import 'package:user_management_tool/providers/OperationalLogProvider.dart';
import 'package:user_management_tool/widgets/dialogs/IdentificationFailedDialog.dart';

class IdentificationDialog {
  GlobalKey navigatorKey;
  late Timer captchaTimer;
  bool inUse = false;
  IdentificationDialog(this.navigatorKey) {
    if (inUse || CURRENT_USER == null) {
      return;
    }
    var captchaImages = [
      "lib/images/captcha-1.jpg",
      "lib/images/captcha-2.jpg",
      "lib/images/captcha-3.jpg",
      "lib/images/captcha-4.jpg",
      "lib/images/captcha-5.jpg"
    ];
    var randomImage = (captchaImages..shuffle()).first;

    inUse = true;
    captchaTimer = Timer(Duration(seconds: 20), captchaTimeout);
    show(randomImage);
  }

  show(String image) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 280,
            height: 280,
            padding: const EdgeInsets.all(8.0),
            child: SliderCaptcha(
              title: "Slide to unlock",
              image: Image.asset(
                image,
                fit: BoxFit.fitWidth,
              ),
              onSuccess: () => {
                inUse = false,
                captchaTimer.cancel(),
                Navigator.of(navigatorKey.currentContext!).pop(),
                OperationalLogProvider.insert(Logger(action: OperationalLogAction.IDENTIFICATION_PASSED))
              },
            ),
          ),
        );
      },
    );
  }

  captchaTimeout() async {
    captchaTimer.cancel();
    OperationalLogProvider.insert(Logger(action: OperationalLogAction.IDENTIFICATION_FAILED));
    CURRENT_USER = null;
    inUse = false;
    Navigator.of(navigatorKey.currentContext!).pop(true);
    await IdentificationFailedDialog.show(navigatorKey.currentContext!);
  }
}
