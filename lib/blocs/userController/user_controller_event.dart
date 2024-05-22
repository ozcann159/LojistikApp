import 'package:flutter/material.dart';

abstract class UserControllerEvent {}

class RegisterEvent extends UserControllerEvent {
  String name;
  String surname;
  String email;
  String password;
  String confirmPassword;
  BuildContext context;

  RegisterEvent({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.context,
  });
}