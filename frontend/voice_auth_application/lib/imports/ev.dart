import 'package:flutter/material.dart';

const String ipAddr = "http://192.168.1.21:8000"; // ip address of the server
Color backgroundColor = const Color(0xff3E4768);
Color elevatedButtonColor = const Color(0xff1569C7);
Color cardColor = const Color(0xffEBF4FA);
Color floatingButtonColor = const Color(0xff32cd32);

// TextFieldForm decoration
const inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2),
    ));

const noteTitleDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xff3E4768),
  hintText: 'Title',
  hintStyle: TextStyle(
    color: Color(0xffacacac),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff3E4768), width: 0),
  ),
);

const noteBodyDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xff3E4768),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff3E4768), width: 0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff3E4768), width: 0),
  ),
);
