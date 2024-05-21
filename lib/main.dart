import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/Pages/splash_page.dart';
import 'package:loadspotter/blocs/load/load_bloc.dart';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoadBloc>(
          create: (context) => LoadBloc(), // LoadBloc'ı burada oluşturun
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: ThemeData(
            fontFamily: "Poppins",
            primaryColor: const Color.fromARGB(255, 69, 181, 73), // Ana renk
            scaffoldBackgroundColor:
                Color.fromARGB(255, 56, 170, 61), // Arka plan rengi
            textTheme: TextTheme(
              bodySmall: TextStyle(color: textColor),
              bodyMedium: TextStyle(color: textColor), // Başka bir metin rengi
            ),
          ),
          home: SplashPage()),
    );
  }
}
