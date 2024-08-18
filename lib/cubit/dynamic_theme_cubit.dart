// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';



class DynamicThemeCubit extends Cubit<ThemeData> {
  DynamicThemeCubit() : super(themeLight);

  static final ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );

 static final ThemeData themeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    primarySwatch: Colors.grey, // or remove this line if not needed
  );

  void toogleThem() {
    emit(state.brightness == Brightness.dark ? themeDark : themeLight);
  }
}
