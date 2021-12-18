import 'dart:convert';

import 'package:http/http.dart' as http;

getReservationData() async {
  var response = await http
      .get(Uri.parse("https://baranhweb.cmcmtech.com/api/reservelist/1"));
  var jsonData = jsonDecode(response.body);
  return jsonData["result"];
}
