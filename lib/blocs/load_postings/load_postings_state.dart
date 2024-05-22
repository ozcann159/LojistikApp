part of 'load_postings_bloc.dart';

abstract class LoadPostingsState extends Equatable {
  const LoadPostingsState();

  @override
  List<Object> get props => [];
}

class LoadPostingsLoading extends LoadPostingsState {}

class LoadPostingsLoaded extends LoadPostingsState {
  final List<LoadPosting> loadPostings;

  const LoadPostingsLoaded(this.loadPostings);

  @override
  List<Object> get props => [loadPostings];
}

class LoadPostingsError extends LoadPostingsState {}
