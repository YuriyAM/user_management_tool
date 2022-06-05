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
  bool inUse = false;
  IdentificationDialog(this.navigatorKey) {
    if (inUse || CURRENT_USER == null) {
      return;
    }
    print("here");
    var captchaImages = [
      "lib/images/captcha-1.jpg",
      "lib/images/captcha-2.jpg",
      "lib/images/captcha-3.jpg",
      "lib/images/captcha-4.jpg",
      "lib/images/captcha-5.jpg"
    ];
    var randomImage = (captchaImages..shuffle()).first;

    inUse = true;
    Timer t = Timer(Duration(minutes: 1), captchaTimeout);
    show(t, randomImage);
  }

  show(Timer t, String image) {
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
                t.cancel(),
                Navigator.of(navigatorKey.currentContext!).pop(),
                OperationalLogProvider.insert(Logger(action: OperationalLogAction.IDENTIFICATION_PASSED))
              },
            ),
          ),
        );
      },
    );
  }

  captchaTimeout() {
    CURRENT_USER = null;
    inUse = false;
    OperationalLogProvider.insert(Logger(action: OperationalLogAction.IDENTIFICATION_FAILED));
    Navigator.of(navigatorKey.currentContext!).pop(true);
    IdentificationFailedDialog.show(navigatorKey.currentContext!);
  }
}
