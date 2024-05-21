import 'package:equatable/equatable.dart';

abstract class LoadState extends Equatable {
  const LoadState();

  @override
  List<Object?> get props => [];
}

class LoadInitial extends LoadState {}

class LoadInProgress extends LoadState {}

class LoadSuccess extends LoadState {
  final List<dynamic> data;

  const LoadSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class LoadFailure extends LoadState {
  final String errorMessage;

  const LoadFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
