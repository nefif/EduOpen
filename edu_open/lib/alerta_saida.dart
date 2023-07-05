import 'package:edu_open/start_page.dart';
import 'package:flutter/material.dart';

class ShowAlert {
  static void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja Sair?'),
          actions: [
            TextButton(
              onPressed: () {
                // Fecha o modal e redireciona para a tela de login
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => StartPage(),
                  ),
                );
              },
              child: const Text('SIM'),
            ),
            TextButton(
              onPressed: () {
                // Fecha o modal
                Navigator.of(context).pop();
              },
              child: const Text('NÃO'),
            ),
          ],
        );
      },
    );
  }
}

