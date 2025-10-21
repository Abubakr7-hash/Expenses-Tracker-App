import 'package:expense_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromRGBO(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //! /////////////////////// Dark Theme /////////////////////
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            color: kDarkColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          titleMedium: TextStyle(
            color: kDarkColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          titleSmall: TextStyle(
            color: kDarkColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w100,
            fontSize: 12,
          ),
        ),
        iconTheme: IconThemeData().copyWith(
          color: kDarkColorScheme.onSecondaryContainer,
        ),
      ),
      //! /////////////////////// Light Theme /////////////////////
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          titleMedium: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          titleSmall: TextStyle(
            color: kColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w100,
            fontSize: 12,
          ),
        ),

        iconTheme: IconThemeData().copyWith(
          color: kColorScheme.onSecondaryContainer,
        ),
      ),
      themeMode: ThemeMode.light,
      home: Expenses(),
    ),
  );
}
