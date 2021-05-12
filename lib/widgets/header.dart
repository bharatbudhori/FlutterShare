import 'package:flutter/material.dart';

AppBar header() {
  return AppBar(
    title: Text(
      'FlutterShare',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Signatra',
        fontSize: 40,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.teal,
  );
}
