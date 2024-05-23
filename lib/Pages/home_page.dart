import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/add_load_posting_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük İlanları'),
      ),
      body: Center(
        child: Text('Yük ilanları burada listelenecek'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddLoadPostingScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
