import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';

class FavoritesPage extends StatefulWidget {
  final List<Item> favoriteItems;

  const FavoritesPage({super.key, required this.favoriteItems});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Favoritos'),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteItems.length,
        itemBuilder: (context, index) {
          final item = widget.favoriteItems[index];
          return ListTile(
            title: Text(item.headerValue),
            subtitle: Text(item.expandedValue),
            onTap: () async {
              if (await launchUrl(item.link)) {
                await launchUrl(item.link);
              } else {
                throw 'Não foi possível abrir o link: ${item.link}';
              }
            },
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  widget.favoriteItems.remove(item);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
