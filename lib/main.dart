import 'package:flutter/material.dart';
import 'package:foodb/locator.dart';
import 'package:foodb/router.dart';
import 'package:foodb/ui/pages/page_main.dart';

void main() {
  initLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Color(0xFFF4FAFC),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Color(0xFF000000)),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF202020),
          ),
          headline2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF383838),
          ),
          headline3: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        accentColor: Color(0x40F4FAFC),
        scaffoldBackgroundColor: Color(0xff202020),
        dialogBackgroundColor: Color(0xFF202020),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF101010),
          selectedItemColor: Color(0xFFD0D0D0),
          unselectedItemColor: Color(0xFFBBBBBB)
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFFD0D0D0),
          ),
          headline2: TextStyle(
            color: Color(0xFFD0D0D0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: Color(0xFFC0C0C0),
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PageMain(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
