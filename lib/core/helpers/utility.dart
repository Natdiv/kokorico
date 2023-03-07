import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kokorico/core/helpers/enum.dart';
import 'package:vibration/vibration.dart';

import '../theme/colors.dart';

final kAnalytics = FirebaseAnalytics.instance;
void cprint(dynamic data,
    {String? errorIn, String? event, String label = 'Log'}) {
  /// Print logs only in development mode
  if (kDebugMode) {
    if (errorIn != null) {
      print(
          '****************************** error ******************************');
      developer.log('[Error]',
          time: DateTime.now(), error: data, name: errorIn);
      print(
          '****************************** error ******************************');
    } else if (data != null) {
      developer.log(data, time: DateTime.now(), name: label);
    }
    if (event != null) {
      Utility.logEvent(event, parameter: {});
    }
  }
}

class Utility {
  static void logEvent(String event, {Map<String, dynamic>? parameter}) {
    kReleaseMode
        ? kAnalytics.logEvent(name: event, parameters: parameter)
        : print("[EVENT]: $event");
  }
}

// The rolw of the user
class UserRole {
  static const String SUPER = 'SUPER';
  static const String ADMIN = 'ADMIN';
  static const String USER = 'USER';
}

SnackBar snackBar(String message) => SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
      ),
      backgroundColor: Colors.black.withOpacity(0.75),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(milliseconds: 5000),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.up,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      onVisible: () async {
        if (await Vibration.hasVibrator() ?? false) {
          Vibration.vibrate(duration: 300);
        }
      },
    );

int getFromTodayDate() {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  DateTime time = DateTime(year, month, day);
  return time.millisecondsSinceEpoch;
}

String getFormattedDate(int date) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(date);
  return '${time.day}/${time.month}/${time.year} - ${time.hour}:${time.minute}';
}

String getFormattedPrice(double price) {
  var f =
      NumberFormat.simpleCurrency(locale: 'fr_FR', name: '', decimalDigits: 0);
  var value = '${f.format(price)} FC';
  return value;
}

String getOrderStatus(String status) {
  if (status == OrderStatus.PENDING.toString()) {
    return 'En attente';
  } else if (status == OrderStatus.PROCESSING.toString()) {
    return 'En cours';
  } else if (status == OrderStatus.COMPLETED.toString()) {
    return 'Livrée';
  }
  return 'Annulée';
}

String getPaymentMethod(String method) {
  if (PaymentMethod.MOBILE_MONEY.toString() == method) {
    return 'Mobile Money';
  }
  return 'Paiement Cash';
}
