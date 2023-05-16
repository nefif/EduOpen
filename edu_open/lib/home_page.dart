import 'package:edu_open/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: MenuDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildCard('Card 1', Icons.access_alarm),
          _buildCard('Card 2', Icons.access_time),
          _buildCard('Card 3', Icons.accessibility),
          _buildCard('Card 4', Icons.account_balance),
        ],),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos')
      ]),
    );
  }
}

Widget _buildCard(String title, IconData icon) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 48.0,
              ),
              SizedBox(height: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
