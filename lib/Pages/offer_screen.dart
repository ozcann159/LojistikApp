// offer_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_event.dart';
import 'package:loadspotter/blocs/offer/offer_state.dart';
import 'package:loadspotter/models/offer.dart';


class OfferScreen extends StatelessWidget {
  final String loadPostingId;

  OfferScreen({required this.loadPostingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          } else if (state is OfferError) {
            return Center(child: Text('Hata: ${state.message}'));
          } else {
            return Center(child: Text('Teklifler yüklenemedi'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Teklif ekleme işlemini başlat
          final newOffer = Offer(price: 0, status: '', id: '', loadPostingId: '', userId: '');
          BlocProvider.of<OffersBloc>(context).add(OfferAdded(newOffer));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
