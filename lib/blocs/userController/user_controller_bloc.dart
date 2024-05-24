import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/blocs/userController/user_controller_event.dart';
import 'package:loadspotter/blocs/userController/user_controller_state.dart';
import 'package:loadspotter/repositories/auth_repository.dart';

class UserControllerBloc
    extends Bloc<UserControllerEvent, UserControllerState> {
  final AuthRepository firebaseAuthRepo;
  UserControllerBloc({required this.firebaseAuthRepo})
      : super(UserControllerInitial()) {
    on<RegisterEvent>((event, emit) async {
      final message = await firebaseAuthRepo.register(event.name, event.surname,
          event.email, event.password, event.confirmPassword);

      if (message == "Kayıt Başarılı!") {
        Navigator.pop(event.context);
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
          content: Text(message!),
        ));
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
          content: Text(message!),
        ));
      }
    });
  }
}
