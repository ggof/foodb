import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/locator.dart';
import 'package:foodb/router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeListAdapter());
  await initLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF6688FF),
        accentColor: Color(0xFFF4FAFC),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(selectedItemColor: Color(0xFF000000)),
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
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFF6688FF)),
      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xFF6688FF),
        accentColor: Color(0x40F4FAFC),
        scaffoldBackgroundColor: Color(0xff202020),
        dialogBackgroundColor: Color(0xFF202020),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF101010),
            selectedItemColor: Color(0xFFD0D0D0),
            unselectedItemColor: Color(0xFFBBBBBB)),
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
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFF6688FF)),
        iconTheme: IconThemeData(color: Colors.white),
        dialogTheme:
            DialogTheme(backgroundColor: Color(0xFFD0D0D0), elevation: 0),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: onGenerateRoute,
    );
  }
}

class RecipeListAdapter implements TypeAdapter<List<Recipe>> {
  @override
  List<Recipe> read(BinaryReader reader) {
    final str = reader.readString();
    final json = jsonDecode(str);
    final state =
        (json as List<dynamic>).map((e) => Recipe.fromJson(e)).toList();

    return state;
  }

  @override
  int get typeId => 32;

  @override
  void write(BinaryWriter writer, List<Recipe> obj) {
    final json = obj.map((e) => e.toJson()).toList();
    final str = jsonEncode(json);
    writer.writeString(str);
  }
}
