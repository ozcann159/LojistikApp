import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/auth/auth.state.dart';
import 'package:loadspotter/repositories/auth_repository.dart';
import 'auth_event.dart';
 
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository; // AuthRepository örneği

  AuthBloc(this._authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInEvent) {
      yield* _mapSignInEventToState(event);
    } else if (event is SignUpEvent) {
      yield* _mapSignUpEventToState(event);
    }
  }

  Stream<AuthState> _mapSignInEventToState(SignInEvent event) async* {
    yield SigningInState(); // Giriş yapılıyor durumunu bildir
    try {
      final result = await _authRepository.signIn(event.email, event.password);
      if (result == "Giriş Başarılı") {
        yield SignInSuccessState();
      } else {
        yield SignInFailureState(result);
      }
    } catch (error) {
      yield SignInFailureState(error.toString()); // Giriş başarısız durumunu bildir
    }
  }

  Stream<AuthState> _mapSignUpEventToState(SignUpEvent event) async* {
    yield SigningUpState(); // Kayıt olunuyor durumunu bildir
    try {
      final result = await _authRepository.signUp(event.email, event.password);
      if (result == "Kayıt Başarılı") {
        yield SignUpSuccessState();
      } else {
        yield SignUpFailureState(result!);
      }
    } catch (error) {
      yield SignUpFailureState(error.toString()); 
    }
  }

  
}
