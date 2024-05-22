// offer_state.dart

import 'package:equatable/equatable.dart';
import 'package:loadspotter/models/offer.dart';

abstract class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object> get props => [];
}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersLoaded extends OffersState {
  final List<Offer> offers;

  const OffersLoaded(this.offers);

  @override
  List<Object> get props => [offers];
}

class OfferError extends OffersState {
  final String message;

  const OfferError({required this.message});

  @override
  List<Object> get props => [message];
}
