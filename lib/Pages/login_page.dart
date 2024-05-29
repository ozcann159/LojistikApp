import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/add_load_posting_screen.dart';
import 'package:loadspotter/Pages/driver_register.dart';
import 'package:loadspotter/Pages/load_postings_screen.dart';
import 'package:loadspotter/Pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  Future<void> signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = emailTextEditingController.text;
      String password = passwordTextEditingController.text;
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .get();
        String userType = userDoc['userType'];

        if (userType == 'Driver') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DriverRegistrationPage()),
          );
        } else if (userType == 'Freighter') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoadPostingsScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Invalid user type'),
          ));
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign in: ${e.message}'),
        ));
      }
    }
  }

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
                        fontWeight: FontWeight.bold,
                      ),
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
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.shade300,
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.green.shade50,
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: emailTextEditingController,
                                  decoration: const InputDecoration(
                                    hintText: "E-Posta",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    prefixIcon:
                                        Icon(Icons.person_outline_rounded),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Lütfen e-posta adresinizi giriniz';
                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                        .hasMatch(value)) {
                                      return 'Geçersiz e-posta adresi';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.green.shade50,
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: passwordTextEditingController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Parola",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Lütfen parolanızı doğru giriniz';
                                    } else if (value.length < 6) {
                                      return 'Parola en az 6 karakter olmalıdır';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: signIn,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Colors.green.shade600,
                            ),
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                  color: Colors.green.shade600,
                                ),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              "Kayıt Ol",
                              style: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DriverRegistrationPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.green.shade600),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "Şoför olarak kayıt ol",
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddLoadPostingScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.green.shade600),
                          ),
                        ),
                        child: Text(
                          "Yük Taşıtan olarak kayıt ol",
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Şifremi Unuttum",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
