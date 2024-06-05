import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _navigateToLogin(BuildContext context, String userType) async {
  try {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(userType: userType),
      ),
    );

    if (result != null && result) {
      // Kullanıcı giriş yaptıysa Firebase Authentication ile işlem yapılacak
      // Örneğin, kullanıcı kaydedilecek veya kullanıcı türü belirlenecek
      // Burada FirebaseAuth.instance.currentUser ile giriş yapmış kullanıcı bilgilerine erişebilirsiniz.
    }
  } catch (e) {
    print('Giriş hatası: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
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
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async => await _navigateToLogin(context, 'shipper'), // shipper userType'ını doğru alıyor mu?
              child: const Text(
                "Taşınacak Yüküm Var",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async => await _navigateToLogin(context, 'driver'), // driver userType'ını doğru alıyor mu?
              child: const Text(
                "Nakliyeciyim Aracım Var",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
