import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_event.dart';
import 'package:loadspotter/blocs/offer/offer_state.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final FirestoreService firestoreService;

  OffersBloc({required this.firestoreService}) : super(OffersInitial()) {
    on<OfferAdded>(_onOfferAdded);
  }

  Stream<OffersState> _onOfferAdded(OfferAdded event, Emitter<OffersState> emit) async* {
    try {
      yield OffersLoading();
      await firestoreService.addOffer(event.offer);
      yield const OffersLoaded([]);
    } catch (e) {
      yield OfferError(message: e.toString());
    }
  }

  @override
  Stream<OffersState> mapEventToState(OffersEvent event) async* {
    // Bu metod içinde başka olaylar da işlenebilir.
  }
}
