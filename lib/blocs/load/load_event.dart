import 'package:equatable/equatable.dart';

abstract class LoadEvent extends Equatable {
  const LoadEvent();

  @override
  List<Object?> get props => [];
}

class LoadStarted extends LoadEvent {}

class LoadCompleted extends LoadEvent {}

class LoadFailed extends LoadEvent {
  final String errorMessage;

  const LoadFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
