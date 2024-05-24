import 'package:flutter_bloc/flutter_bloc.dart';
import 'load_event.dart';
import 'load_state.dart';

class LoadBloc extends Bloc<LoadEvent, LoadState> {
  LoadBloc() : super(LoadInitial());

  Stream<LoadState> mapEventToState(LoadEvent event) async* {
    if (event is LoadStarted) {
      yield* _mapLoadStartedToState();
    } else if (event is LoadCompleted) {
      yield const LoadSuccess([]);
    } else if (event is LoadFailed) {
      yield LoadFailure(event.errorMessage);
    }
  }

  Stream<LoadState> _mapLoadStartedToState() async* {
    // Yükleme işlemi burada gerçekleştirilir
    yield LoadInProgress();
    try {
      // Yükleme işlemi başarılıysa
      yield const LoadSuccess( []);
    } catch (error) {
      // Yükleme işlemi başarısızsa
      yield LoadFailure(error.toString());
    }
  }
}
