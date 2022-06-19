import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:searching_dataverse/services/error/failure.dart';
import 'package:searching_dataverse/utils/router/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


extension ScaffoldHelper on BuildContext? {
  void show({required String message, SnackBarBehavior? snackBarBehavior = SnackBarBehavior.fixed}) {
    if (this == null) {
      return;
    }

    ScaffoldMessenger.maybeOf(this!)
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: snackBarBehavior,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        duration: Duration(seconds: 2),
      ));
  }

  void showMainScreenSnack({required String message, SnackBarBehavior? snackBarBehavior = SnackBarBehavior.fixed}) {
    if (this == null) {
      return;
    }

    ScaffoldMessenger.maybeOf(this!)
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        padding: EdgeInsetsDirectional.only(bottom: AppBar().preferredSize.height * 0.85, top: 10),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ));
  }
}

extension FileSizeCalculator on String {
  // This method gets the size of image
  double calculateFileSize() {
    var file = File(this);
    final bytes = file.lengthSync();
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb;
  }
}

extension PhoneNumberFormatter on String {
  String formatPhoneNumber() {
    var phoneNumber = this;

    if (phoneNumber.split('').first == '0') {
      phoneNumber = phoneNumber.substring(1);
    }

    return phoneNumber;
  }
}

extension LocaleHelper on Locale {
  String getLocaleStringFromLocaleObject() => "${languageCode}${countryCode == null ? "" : "-${countryCode}"}";
}

extension FixedLengthString on num {
  String truncateToDecimalPlaces(int fractionalDigits) {
    var value = (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
    return value.toStringAsFixed(fractionalDigits);
  }

  double truncateToDecimalPlacesDouble(int fractionalDigits) {
    var value = (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
    return double.parse(value.toStringAsExponential(fractionalDigits));
  }
}

extension NoInternetConnectionHelper on Failure {
  void checkAndTakeAction({required ValueChanged<String>? onError}) {
    var appState = GetIt.I.get<AppState>();
    if (this is NetworkFailure) {
      appState.moveToNoInternetScreen();
      return;
    }
    // if (this is LoginTokenExpiredFailure || this is TooManyAttemptsFailure) {
    //   appState.moveToPasscodeBiometricScreen();
    // } else {
      onError?.call(message);
    // }
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension GetJsonFromJWT on String {
  bool isTokenExpired() {
    var splittedString = split('.')[1];
    var normalizedSource = base64Url.normalize(splittedString);
    var jsonString = utf8.decode(base64Url.decode(normalizedSource));

    final expirationDate = DateTime.fromMillisecondsSinceEpoch(0).add(Duration(seconds: jsonDecode(jsonString)['exp'].toInt()));

    final thresholdDate = DateTime.now().add(Duration(seconds: 30));

    return thresholdDate.isAfter(expirationDate);
  }

  bool isRefreshNeeded() {
    var splittedString = split('.')[1];
    var normalizedSource = base64Url.normalize(splittedString);
    var jsonString = utf8.decode(base64Url.decode(normalizedSource));

    final expirationDate = DateTime.fromMillisecondsSinceEpoch(0).add(Duration(seconds: jsonDecode(jsonString)['exp'].toInt()));

    final thresholdDate = DateTime.now().add(Duration(minutes: 2));

    return thresholdDate.isAfter(expirationDate);
  }
}

