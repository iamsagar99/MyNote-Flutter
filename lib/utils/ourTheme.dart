import 'package:flutter/material.dart';

class OurTheme{

  Color _lightGreen  = Color.fromARGB(255, 255, 255, 255);
  Color _ligntGrey  = Color.fromARGB(255, 164, 164, 164);
  Color _darkerGrey  = Color.fromARGB(255, 119, 124, 135);

  ThemeData buildTheme(){
    return ThemeData(
      canvasColor: _lightGreen,
      primaryColor: _lightGreen,
      accentColor: _ligntGrey,
      secondaryHeaderColor: _darkerGrey,
      hintColor: _ligntGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: Colors.white,
          )
        ),
        focusedBorder:   OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
        color: Colors.black26,
        )
          )

    )
    );
  }
}