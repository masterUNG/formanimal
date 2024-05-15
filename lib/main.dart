import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formanimal/states/list_swine_code.dart';
import 'package:get/get.dart';

void main() {
  HttpOverrides.global = MyHttpOverride();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ListSwineCode(),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
   
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
