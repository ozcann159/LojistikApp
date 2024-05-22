import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_event.dart';
import 'package:loadspotter/blocs/offer/offer_state.dart';
import 'package:loadspotter/models/offer.dart';
import 'package:loadspotter/repositories/firestore_services.dart';


class OfferScreen extends StatelessWidget {
  final String loadPostingId;

  OfferScreen({required this.loadPostingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersBloc(firestoreService: FirestoreService()), 
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teklifler'),
        ),
        body: BlocBuilder<OffersBloc, OffersState>(
          builder: (context, state) {
            if (state is OffersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OffersLoaded) {
              final offers = state.offers;

              return ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  return ListTile(
                    title: Text('Teklif: ${offer.price} TL'),
                    subtitle: Text('Durum: ${offer.status}'),
                  );
                },
              );
            } else {
              return Center(child: Text('Teklifler yüklenemedi'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Yeni bir teklif ekleme işlemi başlat
            _navigateToAddOfferScreen(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _navigateToAddOfferScreen(BuildContext context) {
    // Yeni teklif ekranına yönlendirme
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddOfferScreen(loadPostingId: loadPostingId),
      ),
    );
  }
}

class AddOfferScreen extends StatelessWidget {
  final String loadPostingId;

  AddOfferScreen({required this.loadPostingId});

  @override
  Widget build(BuildContext context) {
    // Yeni teklif ekranının oluşturulması
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Teklif Ekle'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Yeni teklif ekleme işlemi
            final newOffer = Offer(
              id: 'new_offer_id',
              userId: 'user123',
              loadPostingId: loadPostingId,
              price: 0, // Burada varsayılan bir fiyat belirleyebilirsiniz
              status: 'Pending', // Varsayılan durumu belirleyin
              // Diğer özellikler
            );
            context.read<OffersBloc>().add(OfferAdded(newOffer));
            Navigator.of(context).pop(); // Ekranı kapat
          },
          child: Text('Teklif Ekle'),
        ),
      ),
    );
  }
}
