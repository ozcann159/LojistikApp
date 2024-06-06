import 'package:equatable/equatable.dart';

abstract class ShipperRegistrationState extends Equatable {
  const ShipperRegistrationState();

  @override
  List<Object> get props => [];
}

class ShipperRegistrationInitial extends ShipperRegistrationState {}

class ShipperRegistrationLoading extends ShipperRegistrationState {}

class ShipperRegistrationSuccess extends ShipperRegistrationState {}

class ShipperRegistrationFailure extends ShipperRegistrationState {
  final String error;

  const ShipperRegistrationFailure(this.error);

  @override
  List<Object> get props => [error];
}
