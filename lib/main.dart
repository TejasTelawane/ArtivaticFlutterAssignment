import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/ListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // To hide the debug banner
      title: 'Artivatic Flutter Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListScreen(), // First Screen of the App
    );
  }
}
