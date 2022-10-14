import 'package:appsicle_flutter/common.dart';

class AppsicleFlutterUtils {
  static Future<dynamic> submitSupportQuery(
      {required String siteId,
      required String pageId,
      required String name,
      required String email,
      required String message}) async {
    return await Network().postData({
      'full_name': name,
      'email_address': email,
      'message': message,
    }, siteId: siteId, pageId: pageId, apiUrl: 'form-submit');
  }
}
