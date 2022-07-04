import 'dart:convert';
import 'package:http/http.dart' as http;

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class Network {
  final String _url = 'https://appsicle.co/api/v1/';

  String? token;

  String getAssetPath(String path) {
    return "${_url}/files/${path}";
  }

  Future<dynamic> getData(String siteId, String pageId) async {
    var fullUrl = _url + "${siteId}/${pageId}";

    return parseResponse(http.get(Uri.parse(fullUrl), headers: setHeaders()));
  }

  Future<dynamic> parseResponse(request) async {
    http.Response res = await request;

    if (![200, 201, 204].contains(res.statusCode)) {
      return Future.error(res);
    }

    return json.decode(utf8.decode(res.bodyBytes));
  }

  Map<String, String> setHeaders({String contentType = 'application/json'}) => {
        'Content-type': contentType,
      };
}
