import 'package:baranh/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

Widget inputTextField(context, label, myController,
    {function, function2, password = false}) {
  return Container(
    color: myWhite,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (function == "") ? () {} : function,
      controller: myController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      obscureText: password == true ? obscureText : false,
      cursorColor: myBlack,
      cursorWidth: 2.0,
      cursorHeight: dynamicHeight(context, .03),
      style: TextStyle(
        color: myBlack,
        fontSize: dynamicWidth(context, .04),
      ),
      decoration: InputDecoration(
        suffixIcon: password == false
            ? null
            : InkWell(
                onTap: function2 == "" ? () {} : function2,
                child: Icon(
                  Icons.remove_red_eye_rounded,
                  color: myBlack,
                  size: dynamicWidth(context, .06),
                ),
              ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: myBlack,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .01),
          horizontal: dynamicWidth(context, .05),
        ),
      ),
    ),
  );
}

Widget searchbar(context, {enabled = true, controller, setStateFunction}) {
  return Container(
    height: dynamicHeight(context, .05),
    margin: EdgeInsets.symmetric(
      horizontal: dynamicWidth(context, .014),
    ),
    decoration: BoxDecoration(
      color: noColor,
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .08),
      ),
      border: Border.all(
        color: myWhite,
        width: 1.4,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            autofocus: enabled,
            style: TextStyle(
              color: myBlack,
              fontSize: dynamicWidth(context, .04),
            ),
            cursorColor: myBlack,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Search Your Product",
              hintStyle: const TextStyle(
                color: myBlack,
              ),
              contentPadding: EdgeInsets.only(
                bottom: dynamicHeight(context, .014),
                left: dynamicWidth(context, .05),
              ),
            ),
            onSubmitted: (value) {
              controller.text = value;
              setStateFunction();
            },
          ),
        ),
        InkWell(
          onTap: () {
            setStateFunction();
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: dynamicWidth(context, .02),
            ),
            child: const Icon(
              Icons.search_sharp,
              color: myBlack,
            ),
          ),
        ),
      ],
    ),
  );
}
