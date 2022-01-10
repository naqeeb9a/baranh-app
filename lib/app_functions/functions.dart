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

checkAvailability(date, timeDropdown, seats) async {
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
      return "internet";
    }
  } catch (e) {
    return "server";
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

getWaiters() async {
  try {
    var response = await http
        .get(Uri.parse("https://baranhweb.cmcmtech.com/api/booking-details/1"));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData["data"]["waiters"];
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

reserveTable(name, phone, email, seats, date, dropDownTime) async {
  try {
    var response = await http
        .post(Uri.parse("https://baranhweb.cmcmtech.com/api/reserve"), body: {
      "name": "$name",
      "phone": "$phone",
      "email": "$email",
      "seats": "$seats",
      "date": "$date",
      "timedropdown": "$dropDownTime",
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

assignTableOnline(saleId, tableId) async {
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

assignWaiterOnline(saleId, waiterId) async {
  try {
    var response = await http.post(
        Uri.parse("http://baranhweb.cmcmtech.com/api/assign-waiter"),
        body: {"saleid": saleId, "waiters": waiterId});
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

punchOrder(total, cost) async {
  dynamic bodyJson = {
    "outlet_id": "1",
    "total_items": "3",
    "sub_total": "0",
    "total_payable": "0",
    "total_cost": "0",
    "cart": cartItems,
    "table_no": "12",
    "saleid": "46"
  };
  try {
    var response = await http.post(
      Uri.parse("https://baranhweb.cmcmtech.com/api/booking-punch-order"),
      body: bodyJson,
    );
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    if (response.statusCode == 200) {
      return jsonData["data"];
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
