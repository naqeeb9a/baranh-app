import 'dart:convert';

import 'package:http/http.dart' as http;

getReservationData(qurey) async {
  try {
    var response = await http
        .get(Uri.parse("https://baranhweb.cmcmtech.com/api/$qurey/1"));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"]["result"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

checkAvailibility(String indexValue, date, timedropdown, seats) async {
  try {
    var response = await http
        .post(Uri.parse("https://baranhweb.cmcmtech.com/api/get-avail"), body: {
      "outlet_id": "1",
      "filter_date": "$date",
      "timedropdown": "$timedropdown",
      "seats": "$seats"
    });
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

reserveTable() async {
  try {
    var response = await http
        .post(Uri.parse("https://baranhweb.cmcmtech.com/api/reserve"), body: {
      "name": "naqeeb",
      "phone": "1244325234",
      "email": "naqeeb9a@gmail.com",
      "seats": "5",
      "date": "2021-12-31",
      "timedropdown": "18#50#0#2",
      "outlet_id": "1"
    });
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

arrivedGuests(id) async {
  try {
    var response = await http
        .get(Uri.parse("https://baranhweb.cmcmtech.com/api/guest-arrived/$id"));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

getTimeSlots(outletId, date) async {
  try {
    var response = await http.post(
        Uri.parse("https://baranhweb.cmcmtech.com/api/get-timeslot"),
        body: {"outlet_id": outletId, "filter_date": date});
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
