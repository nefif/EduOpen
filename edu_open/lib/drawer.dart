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
              'Teste',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
          ),
          _buildLogoutTile(context),
        ],
      ),
    );
  }
}
