import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_event.dart';
import 'package:loadspotter/blocs/offer/offer_state.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final FirestoreService firestoreService;

  OffersBloc({required this.firestoreService}) : super(OffersInitial()) {
    on<OfferAdded>(_onOfferAdded);
    on<LoadOffers>(_onLoadOffers);
  }

  void _onOfferAdded(OfferAdded event, Emitter<OffersState> emit) async {
    try {
      emit(OffersLoading());
      await firestoreService.addOffer(event.offer);
      emit(OfferAddedSuccess());
      add(LoadOffers(event.offer.loadPostingId));  // teklifleri yükle
    } catch (e) {
      emit(OfferError(message: e.toString()));
    }
  }

  void _onLoadOffers(LoadOffers event, Emitter<OffersState> emit) async {
    try {
      emit(OffersLoading());
      final offers = await firestoreService.getOffers(event.loadPostingId).first;
      emit(OffersLoaded(offers));
    } catch (e) {
      emit(OfferError(message: e.toString()));
    }
  }
}

class LoadOffers extends OffersEvent {
  final String loadPostingId;

  const LoadOffers(this.loadPostingId);

  @override
  List<Object> get props => [loadPostingId];
}
