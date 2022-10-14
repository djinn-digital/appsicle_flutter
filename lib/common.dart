// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class Network {
  final String _url = 'https://appsicle.co/api/v1/';

  String? token;

  String getAssetPath(String path) {
    return "${_url}/files/${path}";
  }

  Future<dynamic> getData(String siteId, String pageId) async {
    var fullUrl = "$_url${siteId}/${pageId}";

    return parseResponse(http.get(Uri.parse(fullUrl), headers: setHeaders()));
  }

  Future<dynamic> postData(dynamic data,
      {bool noAuth = false,
      required String apiUrl,
      required String pageId,
      required String siteId}) async {
    var fullUrl = "$_url${siteId}/${pageId}/${apiUrl}";
    handleRequestHelper(fullUrl, "POST", jsonEncode(data), setHeaders());

    return parseResponse(http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: setHeaders()));
  }

  Future<dynamic> parseResponse(request) async {
    http.Response res = await request;

    try {
      if (!kReleaseMode) {
        print('{');
        print('  Status: ${res.statusCode}');
        print('  Body: ${json.decode(res.body)}');
        print(' Responded Time: ${DateTime.now()}');
        print('}');
      }
    } catch (e) {
      if (!kReleaseMode) {
        print(e);
      }
    }

    if (![200, 201, 204].contains(res.statusCode)) {
      return Future.error(res);
    }

    return json.decode(utf8.decode(res.bodyBytes));
  }

  void handleRequestHelper(
      String url, String method, dynamic data, dynamic headers) {
    if (!kReleaseMode) {
      print('{');
      print('  Method: $method');
      print('  URL: $url');
      print('  Payload: $data');
      print('  Headers: $headers');
      print(' Start Time: ${DateTime.now()}');
      print('}');
    }
  }

  Map<String, String> setHeaders({String contentType = 'application/json'}) => {
        'Content-type': contentType,
      };
}
