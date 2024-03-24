import 'package:final_640710502/pages/webpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red,),
        useMaterial3: true,
      ),
      home: const webpage(),
    );
  }
}