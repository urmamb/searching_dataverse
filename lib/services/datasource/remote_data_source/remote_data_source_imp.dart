import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';
import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

import '../../error/failure.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final Dio _dio;
  final Logger _log;
  final String _webApiUrl;

  RemoteDataSourceImp({required Dio dio, required Logger log, required webApiUrl})
      : _dio = dio,
        _log = log,
        _webApiUrl = webApiUrl;


  @override
  Future<List<Account>> getAccounts(accessToken) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    final response = await _dio.get('$_webApiUrl/accounts').onError((error, stackTrace) {

      _log.e(error, stackTrace);

      throw AccessTokenFailure('Access Token Failure');
    });

    // _log.i('[remote data source : getAccounts] $response');

    if (response.statusCode == 200) {
      return List.from(response.data['value']).map((e) => Account.fromJson(e)).toList();
    }

    // if (response.statusCode == 200 && response.data != null && response.data['code'] == 2011) {
    //   throw AccessTokenFailure('Access Token Failure');
    // }

    throw AccessTokenFailure('Access Token Failure');
    ;
  }
}
