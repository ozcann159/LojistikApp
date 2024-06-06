import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loadspotter/models/shipper.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

import 'shipper_registration_event.dart';
import 'shipper_registration_state.dart';

class ShipperRegistrationBloc extends Bloc<ShipperRegistrationEvent, ShipperRegistrationState> {
  final FirestoreService _firestoreService;

  ShipperRegistrationBloc(this._firestoreService) : super(ShipperRegistrationInitial());

  @override
  Stream<ShipperRegistrationState> mapEventToState(ShipperRegistrationEvent event) async* {
    if (event is SaveData) {
      yield ShipperRegistrationLoading();

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final shipper = Shipper(
            company: event.company,
            city: event.city,
            contactNumber: event.contactNumber,
            userId: user.uid,
          );
          await _firestoreService.saveShipper(shipper);
          yield ShipperRegistrationSuccess();
        } else {
          yield ShipperRegistrationFailure('Kullanıcı bilgileri alınamadı');
        }
      } catch (e) {
        yield ShipperRegistrationFailure(e.toString());
      }
    }
  }
}
