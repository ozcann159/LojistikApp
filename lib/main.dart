import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/splash_page.dart';
import '../firebase_options.dart';
import 'providers/firebase_auth_provider.dart';
import 'package:provider/provider.dart';


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
    return ChangeNotifierProvider(
      create: (context) => FirebaseAuthProvider(),
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
