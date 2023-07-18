import 'package:edu_open/alerta_saida.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildLogoutTile(BuildContext context) {
      return GestureDetector(
        onTap: () {
          ShowAlert.showLogoutConfirmationDialog(
              context); // Chame a função diretamente
        },
        child: const ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
        ),
      );
    }

    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'EduOpen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Informaçãoes sobre o app'),
                      content: const Text(
                          'Desenvolvido por Néfi Fernandes - 2023 (UFRPE - PGIA)'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Fechar'))
                      ],
                    );
                  });
            },
          ),
          _buildLogoutTile(context),
        ],
      ),
    );
  }
}
