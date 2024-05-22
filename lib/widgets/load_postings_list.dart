import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoadPostingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('postings').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final postings = snapshot.data!.docs;
        return ListView.builder(
          itemCount: postings.length,
          itemBuilder: (context, index) {
            final posting = postings[index];
            return Card(
              child: ListTile(
                title: Text(posting['title']),
                subtitle: Text('Açıklama: ${posting['explanation']}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Teklif ver butonuna basıldığında ne yapılacağını burada belirleyebilirsiniz.
                    // Örneğin: Teklif ekranını açmak için Navigator kullanabilirsiniz.
                  },
                  child: Text('Teklif Ver'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
