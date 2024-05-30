import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/add_load_posting_screen.dart';
import 'package:loadspotter/Pages/load_postings_screen.dart';

class ShipperRegistrationPage extends StatefulWidget {
  const ShipperRegistrationPage({Key? key}) : super(key: key);

  @override
  _ShipperRegistrationPageState createState() =>
      _ShipperRegistrationPageState();
}

class _ShipperRegistrationPageState extends State<ShipperRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _contactNumberController = TextEditingController();

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      String company = _companyController.text;
      String contactNumber = _contactNumberController.text;

      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('shippers')
              .doc(user.uid)
              .set({
            'company': company,
            'contactNumber': contactNumber,
            'userId': user.uid,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Yük taşıtan kaydı başarıyla tamamlandı')),
          );

          // Yönlendirme
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddLoadPostingScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kullanıcı bilgileri alınamadı')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Yük taşıtan kaydı başarısız oldu: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük Taşıtan Kaydı'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(labelText: 'Firma Adı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen firma adını girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'İletişim Numarası'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen iletişim numarasını girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
