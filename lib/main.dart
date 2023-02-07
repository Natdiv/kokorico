import 'package:flutter/material.dart';
import 'package:kokorico/core/theme.dart';
import 'package:kokorico/presentation/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kokorico',
      theme: AppTheme.getTheme(),
      home: const HomePage(),
    );
  }
}
