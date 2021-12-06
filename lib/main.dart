import 'package:baranh/app_screens/home.dart';
import 'package:baranh/app_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final MaterialColor primaryColor = const MaterialColor(
    0xff000000,
    <int, Color>{
      50: Color(0xff000000),
      100: Color(0xff000000),
      200: Color(0xff000000),
      300: Color(0xff000000),
      400: Color(0xff000000),
      500: Color(0xff000000),
      600: Color(0xff000000),
      700: Color(0xff000000),
      800: Color(0xff000000),
      900: Color(0xff000000),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baranh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
        textTheme: GoogleFonts.sourceSansProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Home(),
    );
  }
}
