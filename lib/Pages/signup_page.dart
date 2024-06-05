import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/driver_register.dart';
import 'package:loadspotter/Pages/shipperRegistrationPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  String? userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'İsim'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen adızı giriniz';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: surnameController,
                  decoration: InputDecoration(labelText: 'Soyisim'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen soyadınızı giriniz';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen emailinizi giriniz';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Şifre'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen Şifrenizi Giriniz';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: userType,
                  hint: Text('Kullanıcı Türünü Seçin'),
                  onChanged: (String? newValue) {
                    setState(() {
                      userType = newValue!;
                    });
                  },
                  items: <String>['Driver', 'Shipper']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir kullanıcı türü seçin';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        // Save user type to Firestore
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userCredential.user?.uid)
                            .set({
                          'name': nameController.text,
                          'surname': surnameController.text,
                          'email': emailController.text,
                          'userType': userType,
                        });

                        if (userType == 'Driver') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriverRegistrationPage()),
                          );
                        } else if (userType == 'Shipper') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShipperRegistrationPage()),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Bu e-posta adresi zaten kullanımda. Lütfen farklı bir e-posta deneyin.'),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Kayıt Ol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
