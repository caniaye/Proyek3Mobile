import 'package:flutter/material.dart';
import 'screens/login_kurir_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kurir App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFC7E0E0),
        fontFamily: 'Poppins',
      ),
      home: const LoginKurirPage(),
    );
  }
}