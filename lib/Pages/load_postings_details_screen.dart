import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/models/loadPosting.dart';
import 'package:loadspotter/models/offer.dart';
import 'package:loadspotter/blocs/offer/offer_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_event.dart';
import 'package:loadspotter/blocs/offer/offer_state.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

class LoadPostingDetailsScreen extends StatefulWidget {
  final LoadPosting loadPosting;

  LoadPostingDetailsScreen({required this.loadPosting});

  @override
  _LoadPostingDetailsScreenState createState() => _LoadPostingDetailsScreenState();
}

class _LoadPostingDetailsScreenState extends State<LoadPostingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _offerAmountController = TextEditingController();
  final _deliveryTimeController = TextEditingController();
  final _contactInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OffersBloc>(context).add(LoadOffers(widget.loadPosting.id));
  }

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loadPosting.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Başlık: ${widget.loadPosting.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Açıklama: ${widget.loadPosting.description}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Lokasyon: ${widget.loadPosting.location}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Miktar: ${widget.loadPosting.amount}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _offerAmountController,
                      decoration: InputDecoration(labelText: 'Teklif Miktarı'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Teklif miktarını girin';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _deliveryTimeController,
                      decoration: InputDecoration(labelText: 'Teslim Süresi'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Teslim süresini girin';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contactInfoController,
                      decoration: InputDecoration(labelText: 'İletişim Bilgileri'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'İletişim bilgilerini girin';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newOffer = Offer(
                            id: DateTime.now().toIso8601String(),
                            loadPostingId: widget.loadPosting.id,
                            offerAmount: _offerAmountController.text,
                            deliveryTime: _deliveryTimeController.text,
                            contactInfo: _contactInfoController.text,
                          );
                          BlocProvider.of<OffersBloc>(context).add(OfferAdded(newOffer));
                        }
                      },
                      child: Text('Teklif Ver'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Teklifler:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BlocBuilder<OffersBloc, OffersState>(
                builder: (context, state) {
                  if (state is OffersLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is OffersLoaded) {
                    if (state.offers.isEmpty) {
                      return Text('Henüz teklif yok');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.offers.length,
                      itemBuilder: (context, index) {
                        final offer = state.offers[index];
                        return ListTile(
                          title: Text('Teklif Miktarı: ${offer.offerAmount}'),
                          subtitle: Text('Teslim Süresi: ${offer.deliveryTime}\nİletişim: ${offer.contactInfo}'),
                        );
                      },
                    );
                  } else if (state is OfferError) {
                    return Text('Teklifler yüklenirken hata oluştu: ${state.message}');
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
