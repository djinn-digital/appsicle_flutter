import 'dart:convert';
import 'package:http/http.dart' as http;

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class Network {
  final String _url = 'http://app.appsicle.localdev:3000/api/v1/';

  // final String _url =
  //     'https://el2lig4gd4.execute-api.eu-west-1.amazonaws.com/prod';

  String? token;

  String getAssetPath(String path) {
    return "${_url}/files/${path}";
  }

  Future<dynamic> getData(String siteId, String pageId) async {
    var fullUrl = _url + "${siteId}/${pageId}";

    print(fullUrl);

    return parseResponse(http.get(Uri.parse(fullUrl), headers: setHeaders()));
  }

  Future<dynamic> parseResponse(request) async {
    http.Response res = await request;

    if (![200, 201, 204].contains(res.statusCode)) {
      return Future.error(res);
    }

    return json.decode(res.body);
  }

  Map<String, String> setHeaders({String contentType = 'application/json'}) => {
        'Content-type': contentType,
      };
}
