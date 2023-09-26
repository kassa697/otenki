import 'dart:convert';

import 'package:http/http.dart';

class ZipCpde {
  static Future<Map<String, String>> searchAddress(
      {required String zipCode}) async {
    String url = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode';
    try {
      final result = await get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(result.body);
      // print('''
      // ---------------------
      // data
      // $data
      // ---------------------
      // ''');
      Map<String, String> response = {};
      if (data['message'] != null) {
        response['message'] = data['message'];
      } else {
        if (data['results'] == null) {
          response['message'] = '正しい郵便番号を入力してください';
        } else {
          response['address'] = data['results'][0]['address2'];
        }
      }
      // print('''
      // ---------------------
      // result
      // $response
      // ---------------------
      // ''');
      return response;
    } catch (e) {
      return {'e': 'e'};
    }
  }
}
