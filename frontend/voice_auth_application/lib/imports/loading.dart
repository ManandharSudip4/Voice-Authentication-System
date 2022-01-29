import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voice_auth_app/imports/ev.dart';

// ignore: non_constant_identifier_names
Widget Loading() {
  return Container(
  color: backgroundColor,
  child: const Center(
    child: SpinKitSpinningLines(
      color: Colors.green,
    ),
  ),
);
}

// ignore: non_constant_identifier_names
Widget LoadingNotFullScreen(){
  return const Center(
    child: SpinKitSpinningLines(
      color: Colors.green,
    ),
  );
}