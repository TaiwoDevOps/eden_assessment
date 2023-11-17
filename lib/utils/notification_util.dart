import 'package:another_flushbar/flushbar.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';

enum NotificationMessageType { error }

// for error messages
void showErrorNotification(
  BuildContext context,
  String message, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  _showNotification(
    context,
    message,
    NotificationMessageType.error,
    durationInMills: durationInMills,
    autoDismiss: autoDismiss,
  );
}

void _showNotification(
  BuildContext context,
  String message,
  NotificationMessageType type, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  Flushbar(
    message: message,
    duration: Duration(milliseconds: durationInMills ?? 3000),
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.elasticInOut,
    animationDuration: const Duration(milliseconds: 500),
    backgroundColor: type == NotificationMessageType.error
        ? appColors.error
        : appColors.primaryGreen,
    titleText: Text(
      type == NotificationMessageType.error ? 'Error' : 'Success',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    icon: Icon(
      type == NotificationMessageType.error ? Icons.error : Icons.check_circle,
      color: type == NotificationMessageType.error
          ? Colors.white
          : appColors.primaryGreen,
    ),
    // messageText: Text(message, style: TextStyle(color: Colors.white),),
  ).show(context);
}
