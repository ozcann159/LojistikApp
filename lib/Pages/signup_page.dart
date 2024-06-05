import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Adınız', icon: Icon(CupertinoIcons.person)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen adızı giriniz';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(
                        labelText: 'Soyadınız',
                        icon: Icon(CupertinoIcons.person)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen soyadınızı giriniz';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email', icon: Icon(CupertinoIcons.mail)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen emailinizi giriniz';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Şifre', icon: Icon(CupertinoIcons.eye)),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen Şifrenizi Giriniz';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.group),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
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
                                  builder: (context) =>
                                      DriverRegistrationPage()),
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
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Colors.blue.shade600,
                    ),
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
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
