import 'dart:async';

import 'package:edu_open/splash.dart';
import 'package:edu_open/start_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'EduOpen',
      home: StartPage(),
    );
  }
}

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.delayed(const Duration(seconds: 3));
    runApp(AppWidget());
  }, (error, stackTrace) {
    // ignore: avoid_print
    print('Zone error: $error');
  });
}
