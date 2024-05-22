part of 'load_postings_bloc.dart';

abstract class LoadPostingsEvent extends Equatable {
  const LoadPostingsEvent();

  @override
  List<Object> get props => [];
}

class LoadPostingsRequested extends LoadPostingsEvent {}

class LoadPostingAdded extends LoadPostingsEvent {
  final LoadPosting loadPosting;

  const LoadPostingAdded(this.loadPosting);

  @override
  List<Object> get props => [loadPosting];
}
