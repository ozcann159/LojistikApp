import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadspotter/Pages/login_page.dart';
import 'package:loadspotter/blocs/auth/auth_bloc.dart';
import 'package:loadspotter/blocs/auth/auth_event.dart';
import 'package:loadspotter/blocs/auth/register_event.dart';
import 'package:loadspotter/repositories/auth_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _surnameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

      final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameTextEditingController.dispose();
    _surnameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 200,
                          ),
                        ),
                        const Text(
                          "Hesap Oluştur",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
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
                                      bottom: BorderSide(
                                          color: Colors.green.shade50),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _userNameTextEditingController,
                                    decoration: const InputDecoration(
                                        hintText: "Ad",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        prefixIcon:
                                            Icon(Icons.person_outline_rounded)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.green.shade50),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _surnameTextEditingController,
                                    decoration: const InputDecoration(
                                        hintText: "Soyad",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        prefixIcon:
                                            Icon(Icons.person_outline_rounded)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.green.shade50),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _emailTextEditingController,
                                    decoration: const InputDecoration(
                                        hintText: "E-mail",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.email_outlined)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.green.shade50),
                                    ),
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: _passwordTextEditingController,
                                    decoration: const InputDecoration(
                                        hintText: "Parola",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.fingerprint)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.green.shade50),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        _confirmPasswordTextEditingController,
                                    decoration: const InputDecoration(
                                        hintText: "Parolayı Doğrula",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.fingerprint)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            String email = _emailTextEditingController.text;
                            String password = _passwordTextEditingController.text;
                            try {
                              String result = await AuthRepository().signIn(email, password);
                              if (result == "Giriş Başarılı") {
                                print("giriş başarılı");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Giriş işlemi başarısız: $result"),
                                  ),
                                );
                              }
                            } catch (error) {
                              print("giriş hatalı: $error");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Giriş işlemi başarısız: $error"),
                                ),
                              );
                            }
                          }
                        },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity,
                                  45), // Butonun boyutunu ayarlar
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50), // Butonun kenar yuvarlama miktarını ayarlar
                              ),
                              backgroundColor: Colors.green
                                  .shade600, // Butonun arka plan rengini ayarlar
                            ),
                            child: const Text(
                              "Kayıt Ol",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Hesabın var mı?",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text("Giriş Yap"),
                              ),
                            ],
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
