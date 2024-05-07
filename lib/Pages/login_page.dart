import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade800,
                Colors.green.shade700,
                Colors.green.shade400,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hoşgeldiniz",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Yük Bulmak Sadece Bir Dokunuş Uzağınızda!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.shade300,
                                blurRadius: 20,
                                offset: const Offset(0, 10))
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.green.shade50),
                                ),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                    hintText: "E-Posta veya Telefon Numarası",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.green.shade50),
                                ),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                    hintText: "Parola",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Şifremi Unutum",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 45),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green.shade400),
                        child: const Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Yeni Hesap Oluştur",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 45),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green.shade400),
                        child: const Center(
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 60)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
