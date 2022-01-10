import 'dart:convert';

import 'package:baranh/utils/config.dart';
import 'package:http/http.dart' as http;

getReservationData(query) async {
  try {
    var response = await http
        .get(Uri.parse("https://baranhweb.cmcmtech.com/api/$query/1"));
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

checkAvailability(String indexValue, date, timeDropdown, seats) async {
  try {
    var response = await http
        .post(Uri.parse("https://baranhweb.cmcmtech.com/api/get-avail"), body: {
      "outlet_id": "1",
      "filter_date": "$date",
      "timedropdown": "$timeDropdown",
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

getTables() async {
  try {
    var response = await http
        .get(Uri.parse("https://baranhweb.cmcmtech.com/api/booking-details/1"));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"]["tables"];
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

getMenu() async {
  try {
    var response = await http.post(
        Uri.parse("https://baranhweb.cmcmtech.com/api/searchmenu"),
        body: {"outletid": "1", "term": "all"});
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

assignTable(saleId, tableId) async {
  try {
    var response = await http.post(
        Uri.parse("http://baranhweb.cmcmtech.com/api/assign-table"),
        body: {"sale_id": saleId, "table_id": tableId});
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

punchOrder() async {
  try {
    var response = await http.post(
      Uri.parse("https://baranhweb.cmcmtech.com/api/booking-punch-order"),
      body: {
        "outlet_id": "",
        "total_items": "",
        "sub_total": "",
        "total_payable": "",
        "table_no": "",
        "saleid": "",
        "cart": cartItems,
      },
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
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
