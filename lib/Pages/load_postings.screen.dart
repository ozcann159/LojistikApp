import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/load_postings/load_postings_bloc.dart';


class LoadPostingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük İlanları'),
      ),
      body: BlocBuilder<LoadPostingsBloc, LoadPostingsState>(
        builder: (context, state) {
          if (state is LoadPostingsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadPostingsLoaded) {
            final loadPostings = state.loadPostings;

            return ListView.builder(
              itemCount: loadPostings.length,
              itemBuilder: (context, index) {
                final loadPosting = loadPostings[index];
                return ListTile(
                  title: Text(loadPosting.title),
                  subtitle: Text(loadPosting.description),
                  onTap: () {
                    // İlan detaylarına git
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Yük ilanları yüklenemedi'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yük ilanı ekleme sayfasına git
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
