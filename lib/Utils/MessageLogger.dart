import 'dart:developer';
import 'package:flutter/foundation.dart';

class MessageLogger {
  static logmsg(String title) {
    if (!kReleaseMode) {
      log(title);
    }
  }
}
