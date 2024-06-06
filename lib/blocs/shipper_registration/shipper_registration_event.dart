import 'package:equatable/equatable.dart';

abstract class ShipperRegistrationEvent extends Equatable {
  const ShipperRegistrationEvent();

  @override
  List<Object> get props => [];
}

class SaveData extends ShipperRegistrationEvent {
  final String company;
  final String city;
  final String contactNumber;

  const SaveData(this.company, this.city, this.contactNumber);

  @override
  List<Object> get props => [company, city, contactNumber];
}
