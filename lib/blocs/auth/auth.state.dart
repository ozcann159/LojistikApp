import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class SigningInState extends AuthState {}

class SignInSuccessState extends AuthState {}

class SignInFailureState extends AuthState {
  final String errorMessage;

  SignInFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class SigningUpState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailureState extends AuthState {
  final String errorMessage;

  SignUpFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
