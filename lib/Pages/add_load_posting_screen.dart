import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLoadPostingScreen extends StatefulWidget {
  @override
  _AddLoadPostingScreenState createState() => _AddLoadPostingScreenState();
}

class _AddLoadPostingScreenState extends State<AddLoadPostingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedFromCity = 'Ankara';
  String _selectedToCity = 'Istanbul';
  String _explanation = '';
  String _history = '';

  final List<String> _cities = [
    'Adana', 'Ankara', 'Antalya', 'Bursa', 'Istanbul', 'Izmir', 'Konya'
  ];

  void _addPosting() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('postings').add({
        'title': '$_selectedFromCity - $_selectedToCity',
        'explanation': _explanation,
        'history': _history,
        'id': '', // ID otomatik olarak atanacak
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük İlanı Ekle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                value: _selectedFromCity,
                decoration: InputDecoration(labelText: 'Başlangıç Şehri'),
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFromCity = value as String;
                  });
                },
              ),
              DropdownButtonFormField(
                value: _selectedToCity,
                decoration: InputDecoration(labelText: 'Varış Şehri'),
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedToCity = value as String;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Açıklama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir açıklama girin';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _explanation = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Geçmiş'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen geçmiş bilgisi girin';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _history = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addPosting,
                child: Text('İlanı Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}