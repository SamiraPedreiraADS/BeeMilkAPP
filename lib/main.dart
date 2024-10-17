import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto/Cadastro.dart';
import 'package:flutter_projeto/cake.dart';
import 'package:flutter_projeto/cookies.dart';
import 'package:flutter_projeto/donuts.dart';
import 'package:flutter_projeto/homepage.dart';
import 'package:flutter_projeto/milkshake.dart';
import 'package:flutter_projeto/telalogin.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Ative o DevicePreview
      builder: (context) => const MyApp(), // Chame o app principal
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/cadastro',
      routes: {
        '/login':(context) => LoginScreen(),
        '/cadastro':(context) => SignUpScreen(),
        '/homepage': (context) => HomePage(),
        '/donuts': (context) => DonutsPage(),
        '/cookies': (context) => CookiesPage(),
        '/milkshake': (context) => MilkshakePage(),
        '/cake': (context) => CakesPage(),
      }
    );
  }
}