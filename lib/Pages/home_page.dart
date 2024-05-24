import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loadspotter/Pages/add_load_posting_screen.dart';
import 'package:loadspotter/Pages/load_postings_details_screen.dart';
import 'package:loadspotter/models/loadPosting.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük İlanları'),
      ),
      body: LoadPostingsList(), 
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

class LoadPostingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('loadPostings').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Henüz yük ilanı yok.'));
        } else {
          final loadPostings = snapshot.data!.docs
              .map((doc) => LoadPosting.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: loadPostings.length,
            itemBuilder: (context, index) {
              final loadPosting = loadPostings[index];
              return ListTile(
                title: Text(loadPosting.title),
                subtitle: Text(loadPosting.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadPostingDetailsScreen(loadPosting: loadPosting),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
