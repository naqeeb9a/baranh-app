import 'package:baranh/utils/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToastFlutter(msg) {
  Fluttertoast.showToast(
      msg: msg, backgroundColor: myOrange, textColor: myWhite,);
}
