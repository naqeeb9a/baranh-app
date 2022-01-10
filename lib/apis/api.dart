import 'dart:convert' as convert;

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
    Response<ResponseBody> response;
    var dio = Dio();
    response = await dio.post(
      "https://baranhweb.cmcmtech.com/api/searchmenu",
      data: {"outletid": "1", "term": "all"},
      options: Options(
        responseType: ResponseType.stream,
      ),
    );
    // Response<ResponseBody> rs;
    // rs = await Dio().post<ResponseBody>(
    //   "https://baranhweb.cmcmtech.com/api/searchmenu",
    //   data: {"outletid": "1", "term": "all"},
    //   options: Options(
    //     responseType: ResponseType.stream,
    //   ), // set responseType to `stream`
    // );
    // print(rs.data?.stream);
    // return rs.data?.stream;
    // print(response.data?.stream.toString());
    return response.data?.stream..toString();

    // var url = Uri.https('baranhweb.cmcmtech.com', 'api/$query');
    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse = convert.jsonDecode(response.body);
    //
    //   return jsonResponse["data"];
    // } else {
    //   return false;
    // }
  }
}
