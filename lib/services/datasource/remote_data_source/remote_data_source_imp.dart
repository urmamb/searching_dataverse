import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:searching_dataverse/services/datasource/remote_data_source/remote_data_source.dart';


import '../../error/failure.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final Dio _dio;
  final Logger _log;
  final String _url;

  RemoteDataSourceImp(
      {required Dio dio, required Logger log, required url})
      : _dio = dio,
        _log = log,
        _url = url;

  // String getUrlAndSetLoginToken(String token) {
  //   _dio.options.headers = {LOGIN_TOKEN: token};
  //   return _url;
  // }

}