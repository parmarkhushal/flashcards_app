import 'package:device_preview/device_preview.dart';
import 'package:flashcard_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp( DevicePreview(                            //to view app in different devices layout
  //   builder: (context) => const MainApp(), 
  // ),);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
