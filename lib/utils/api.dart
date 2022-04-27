import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' show Dio, DioError, Options, RequestOptions, Response;

class NetworkApi {

  NetworkApi({
    required this.url
  }) {
    setUrl(url);
  }
  final String url;

  Dio dio = Dio();
  void setUrl(String _url) {
    dio.options.baseUrl = _url;
  }
  void setHeaders(Map<String, dynamic> _headers) {
    dio.options.headers = _headers;
  }

  Future<dynamic> getRequest(String path) async {
    try {
      final RequestOptions request = RequestOptions(
        method: 'GET',
        baseUrl: dio.options.baseUrl,
        path: path
      );
      final Response _res = await dio.fetch(request);
    } on DioError catch (err) {
      rethrow;
    }
  }
}
