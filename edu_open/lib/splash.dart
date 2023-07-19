import 'dart:async';
import 'package:edu_open/start_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    // Chama a função que redireciona para a tela principal após 3 segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Personalize a tela de splash de acordo com as suas necessidades
      body: Center(
        child: Text(
          'EduOpen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
