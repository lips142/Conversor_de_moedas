// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_new, non_constant_identifier_names

import 'package:conversor/splash/splash.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(
      home: Splash(),
      theme: ThemeData(
        primaryColor: Colors.amber,
        hintColor: Colors.amber,
      ),
    ),
  );
}
