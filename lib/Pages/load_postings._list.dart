import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/load_postings_details_screen.dart';
import 'package:loadspotter/models/loadPosting.dart';

class LoadPostingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük İlanları'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('loadPostings').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final loadPostings = snapshot.data!.docs
              .map((doc) =>
                  LoadPosting.fromMap(doc.data() as Map<String, dynamic>))
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
                      builder: (context) =>
                          LoadPostingDetailsScreen(loadPosting: loadPosting),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
