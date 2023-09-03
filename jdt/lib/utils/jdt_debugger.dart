// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:jdt/utils/status_enums.dart';

/* ------------------------------- JdtDebugger ------------------------------ */
/// A helper class to aid with debugging problematic functionality.
class JdtDebugger {
  /* ---------------------------------- print --------------------------------- */
  /// A safe print of whatever [message] is passed into the function along with a
  /// [JdtDebugStatus] to indicate the format the message should take.
  ///
  /// This will only print to the console if it is being ran in debug mode.
  static log(
    String message, {
    JdtDebugStatus status = JdtDebugStatus.info,
  }) {
    if (!kDebugMode) {
      return;
    }

    /// The message format color and prefix
    String messageColor = "\x1B[0m";
    String messagePrefix = "[DEBUGGER] : ";

    /// Stylizing based on passed in [JdtDebugStatus]
    switch (status) {
      case JdtDebugStatus.error:
        messageColor = "\x1B[31m";
        messagePrefix = "[ERROR] : ";
        break;
      case JdtDebugStatus.warning:
        messageColor = "\x1B[33m";
        messagePrefix = "[WARNING] : ";
        break;
      case JdtDebugStatus.info:
        messageColor = "\x1B[36m";
        messagePrefix = "[INFO] : ";
        break;
      case JdtDebugStatus.plain:
        messageColor = "\x1B[0m";
        messagePrefix = "[DEBUGGER] : ";
        break;
      default:
    }

    /// Send message to the console
    print("$messageColor$messagePrefix$message\x1B[0m ");
  }
}
