import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/models/loadPosting.dart';

class AddLoadPostingScreen extends StatefulWidget {
  @override
  _AddLoadPostingScreenState createState() => _AddLoadPostingScreenState();
}

class _AddLoadPostingScreenState extends State<AddLoadPostingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addLoadPosting() async {
    if (_formKey.currentState!.validate()) {
      final String id =
          FirebaseFirestore.instance.collection('loadPostings').doc().id;
      final String title = _titleController.text;
      final String description = _descriptionController.text;
      final String location = _locationController.text;
      final String amount = _amountController.text;

      
      final loadPosting = LoadPosting(
        id: id,
        title: title,
        description: description,
        location: location,
        amount: amount,
      );

      
      await FirebaseFirestore.instance
          .collection('loadPostings')
          .doc(id)
          .set(loadPosting.toMap());

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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Yük Başlığı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Açıklama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Konum'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Yük Miktarı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addLoadPosting,
                child: Text('İlan Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
