// offer_event.dart

import 'package:equatable/equatable.dart';
import 'package:loadspotter/models/offer.dart';

abstract class OffersEvent extends Equatable {
  const OffersEvent();

  @override
  List<Object> get props => [];
}

class OfferAdded extends OffersEvent {
  final Offer offer;

  const OfferAdded(this.offer);

  @override
  List<Object> get props => [offer];
}
