import 'package:flutter/material.dart';

import 'home.dart';

class FavoritesPage extends StatefulWidget {
  final List<Item> favoriteItems;

  const FavoritesPage({required this.favoriteItems});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Favoritos'),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteItems.length,
        itemBuilder: (context, index) {
          final item = widget.favoriteItems[index];
          return ListTile(
            title: Text(item.headerValue),
            subtitle: Text(item.expandedValue),
            trailing: IconButton(
              icon: Icon(Icons.close),
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
