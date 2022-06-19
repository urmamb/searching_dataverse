import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:searching_dataverse/app/app_strings.dart';
import 'package:searching_dataverse/services/datasource/local_data_source/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:searching_dataverse/services/error/failure.dart';

import 'package:searching_dataverse/utils/extensions/extensions.dart';

class LocalDataSourceImp implements LocalDataSource {
  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferences _sharedPreferences;
  // final CacheManager _cacheManager;
  // final DirectoryHelper _directoryHelper;
  // final LocalImagePicker _imagePicker;
  // final LocalContactService _contactService;
  // final SMSService _smsService;
  // final LocalAuthHelper _localAuthHelper;
  // final DynamicLinkHelper _dynamicLinkHelperImpl;

  LocalDataSourceImp({
    required FlutterSecureStorage flutterSecureStorage,
    // required LocalImagePicker imagePicker,
    // required CacheManager cacheManager,
    // required DirectoryHelper directoryHelper,
    required SharedPreferences sharedPreferences,
    // required LocalContactService contactService,
    // required SMSService smsService,
    // required DynamicLinkHelper dynamicLinkHelper,
    // required LocalAuthHelper localAuthHelper,
  })  : _flutterSecureStorage = flutterSecureStorage,
        // _imagePicker = imagePicker,
        // _cacheManager = cacheManager,
        // _directoryHelper = directoryHelper,
        // _contactService = contactService,
        // _smsService = smsService,
        _sharedPreferences = sharedPreferences;
        // _localAuthHelper = localAuthHelper,
        // _dynamicLinkHelperImpl = dynamicLinkHelper;

  final String authToken = 'auth_token';



  @override
  Future<bool> saveAuthToken(String params) async {
    await _flutterSecureStorage.write(key: authToken, value: params);
    return true;
  }

  @override
  Future<String> getAuthToken() async {
    final value = await _flutterSecureStorage.read(key: authToken);
    if (value == null || value.isEmpty) {
      throw SOMETHING_WENT_WRONG;
    }
    return value;
  }

  @override
  Future<bool> clearsSecureStorage() async {
    await _flutterSecureStorage.deleteAll();
    return true;
  }

}
