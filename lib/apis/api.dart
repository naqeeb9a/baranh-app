import 'dart:convert' as convert;

import 'package:baranh/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiData {
  getInfo(query) async {
    var url = Uri.https('baranhweb.cmcmtech.com', 'api/$query');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse["data"];
    } else {
      return false;
    }
  }
}

class DioData {
  getInfo() async {
    var dio = Dio();
    var response = await dio.post(
      "https://baranhweb.cmcmtech.com/api/searchmenu",
      data: {"outletid": outletId, "term": "all"},
    );
    return response;
  }
}
