import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/Pages/driver_register.dart';
import 'package:loadspotter/blocs/load/load_bloc.dart';
import 'package:loadspotter/blocs/offer/offer_bloc.dart';
import 'package:loadspotter/blocs/userController/user_controller_bloc.dart';
import 'package:loadspotter/repositories/auth_repository.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

import 'firebase_options.dart';

const Color primaryColor = Color.fromARGB(15, 240, 123, 255); // Ana renk
const Color secondaryColor = Color(0xFF28a745);
const Color scaffolBackgroundColor = Colors.white;
const Color textColor = Colors.white;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoadBloc>(
          create: (context) => LoadBloc(),
        ),
        BlocProvider<UserControllerBloc>(
          create: (context) =>
              UserControllerBloc(firebaseAuthRepo: AuthRepository()),
        ),
        BlocProvider<OffersBloc>(
          create: (context) => OffersBloc(firestoreService: FirestoreService()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: ThemeData(
            fontFamily: "Poppins",
            primaryColor: const Color.fromARGB(255, 69, 181, 73),
            scaffoldBackgroundColor: const Color.fromARGB(255, 56, 170, 61),
            textTheme: const TextTheme(
              bodySmall: TextStyle(color: textColor),
              bodyMedium: TextStyle(color: textColor),
            ),
          ),
          home: DriverRegistrationPage()),
    );
  }
}
