import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loadspotter/Pages/load_postings_details_screen.dart';
import 'package:loadspotter/models/loadPosting.dart';
import 'package:loadspotter/repositories/firestore_services.dart';


class LoadPostingsScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük İlanları'),
      ),
      body: StreamBuilder<List<LoadPosting>>(
        stream: firestoreService.getLoadPostings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Henüz yük ilanı yok.'));
          } else {
            final loadPostings = snapshot.data!;
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
      ),
    );
  }
}
