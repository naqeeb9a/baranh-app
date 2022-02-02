import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const myWhite = Color(0xffffffff);
const myGrey = Colors.grey;
const myBlack = Color(0xff000000);
const myOrange = Color(0xffff6624);
const myGreen = Color(0xFF008000);
const myRed = Color(0xFFff0000);
const noColor = Colors.transparent;

bool obscureText = true;
var pageDecider = "New Reservations";
dynamic hintText = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
dynamic customContext = "";
dynamic globalRefresh = "";
dynamic saleIdGlobal;
dynamic tableNoGlobal;
dynamic tableNameGlobal;
dynamic globalDineInContext;
dynamic globalDineInRefresh;
dynamic userResponse = "";
dynamic menuRefresh;
dynamic drawerRefresh;
var cartItems = [].obs;
var reservedTable = [];
var callBackUrl = "https://baranh.pk";
var version = "1.2.0";

