import 'package:flutter/material.dart';

import 'favoritos.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> _items = [
    Item(
      headerValue: 'Item 1',
      expandedValue: 'Detalhes do Item 1',
      isExpanded: false,
      isFavorite: false,
    ),
    Item(
      headerValue: 'Item 2',
      expandedValue: 'Detalhes do Item 2',
      isExpanded: false,
      isFavorite: false,
    ),
    Item(
      headerValue: 'Item 3',
      expandedValue: 'Detalhes do Item 3',
      isExpanded: false,
      isFavorite: false,
    ),
  ];
  final List<Item> _favoriteItems = [];

  void _onItemFavoriteChanged(Item item, bool isFavorite) {
    setState(() {
      item.isFavorite = isFavorite;
      if (isFavorite) {
        _favoriteItems.add(item);
      } else {
        _favoriteItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bases Cadastradas'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              _showFavorites();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _buildPanelList(),
        ),
      ),
    );
  }

  Widget _buildPanelList() {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _items[index].isExpanded = !isExpanded;
        });
      },
      children: _items.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: IconButton(
                icon: Icon(
                    item.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: item.isFavorite ? Colors.red : null),
                onPressed: () {
                  setState(() {
                    item.isFavorite = !item.isFavorite;
                    if (item.isFavorite) {
                      _favoriteItems.add(item);
                    } else {
                      _favoriteItems.remove(item);
                    }
                  });
                },
              ),
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void _showFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FavoritesPage(
          favoriteItems: _favoriteItems,
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = false,
    this.isFavorite = false,
  });

  String headerValue;
  String expandedValue;
  bool isExpanded;
  bool isFavorite;
}
