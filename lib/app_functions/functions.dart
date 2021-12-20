import 'dart:convert';

import 'package:http/http.dart' as http;

getReservationData(qurey) async {
  var response =
      await http.get(Uri.parse("https://baranhweb.cmcmtech.com/api/$qurey/1"));
  var jsonData = jsonDecode(response.body);
  return jsonData["result"];
}
