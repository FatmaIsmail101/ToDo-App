import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class NotificationBar {
  static void showNotification({
    required String message,
    required ContentType type,
    required BuildContext context,
    required IconData icon,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating, // ✅ تخليها تطفو فوق بدون تزق المحتوى
      backgroundColor: Colors.transparent, // ✅ يخلي الخلفية شفافة
      content: AwesomeSnackbarContent(
        title: _getTitle(type),
        message: message,
        contentType: type,
      ),
      duration: const Duration(seconds: 3),
    );

    // ✅ نعرضها بالطريقة الصحيحة
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static String _getTitle(ContentType type) {
    switch (type) {
      case ContentType.success:
        return "Success!";
      case ContentType.failure:
        return "Error!";
      case ContentType.warning:
        return "Warning!";
      case ContentType.help:
        return "Note!";
    }
    return"";
  }
}
