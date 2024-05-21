import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/auth/register_event.dart';

import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterUserInfo, RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterUserInfo event) async* {
    if (event is RegisterUserInfo) {
      yield RegisterLoading(); // Kayıt işlemi başladı durumunu bildir
      try {
        // Firebase Authentication kullanarak kullanıcı kaydı gerçekleştirme
        await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        yield RegisterLoaded(); // Kayıt işlemi başarılı durumunu bildir
      } catch (error) {
        yield RegisterError(errorMessage: error.toString()); // Kayıt işlemi başarısız durumunu bildir
      }
    }
  }
}
