import 'package:edu_open/cadastro_pessoal.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduOpen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingUpPersonalPage()),
                );
              },
              child: const Text('Ainda não tem conta? Cadastre-se.'),
            )
          ],
        ),
      ),
    );
  }
}
