import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/login_page.dart';
import 'package:loadspotter/Pages/signup_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 200,
            ),
            const SizedBox(height: 50),
            const Text(
              'Lojistik Yük Dünyası\'na Hoş Geldiniz!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    "Giriş Yap",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Colors.green.shade800),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  SignupPage()));
                  },
                  child: const Text(
                    "Kayıt Ol",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
