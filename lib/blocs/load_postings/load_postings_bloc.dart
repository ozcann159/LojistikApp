import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loadspotter/models/loadPosting.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

part 'load_postings_event.dart';
part 'load_postings_state.dart';

class LoadPostingsBloc extends Bloc<LoadPostingsEvent, LoadPostingsState> {
  final FirestoreService _firestoreService;

  LoadPostingsBloc(this._firestoreService) : super(LoadPostingsLoading()) {
    on<LoadPostingsRequested>((event, emit) async {
      emit(LoadPostingsLoading());
      try {
        await emit.forEach<List<LoadPosting>>(
          _firestoreService.getLoadPostings(),
          onData: (loadPostings) => LoadPostingsLoaded(loadPostings),
          onError: (_, __) => LoadPostingsError(),
        );
      } catch (_) {
        emit(LoadPostingsError());
      }
    });

    on<LoadPostingAdded>((event, emit) async {
      try {
        await _firestoreService.addLoadPosting(event.loadPosting);
      } catch (_) {
        emit(LoadPostingsError());
      }
    });
  }
}
