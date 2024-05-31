import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loadspotter/Pages/load_postings_screen.dart'; 
import 'package:loadspotter/Pages/profile.page.dart';
import 'package:loadspotter/models/loadPosting.dart';

class AddLoadPostingScreen extends StatefulWidget {
  @override
  _AddLoadPostingScreenState createState() => _AddLoadPostingScreenState();
}

class _AddLoadPostingScreenState extends State<AddLoadPostingScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedType = 'Normal'; 

  List<String> _cities = [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Isparta',
    'Mersin',
    'İstanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce'
  ];
  String _selectedLoadingCity = 'Adana';
  String _selectedDestinationCity = 'Sinop';

  DateTime? _selectedDate;

  String _weight = ''; 

  void _addLoadPosting() async {
    if (_formKey.currentState!.validate()) {
      final String id =
          FirebaseFirestore.instance.collection('loadPostings').doc().id;

      final loadPosting = LoadPosting(
        loadType: _selectedType,
        loadingAddress: _selectedLoadingCity,
        destinationAddress: _selectedDestinationCity,
        deliveryDate: _selectedDate!,
        weight: double.parse(_weight.isNotEmpty ? _weight : '0.0'),
      );

      await FirebaseFirestore.instance
          .collection('loadPostings')
          .doc(id)
          .set(loadPosting.toMap());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadPostingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük İlanı Ekle'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: <String>['Normal', 'Hızlı', 'Özel'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Yük Türü'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir yük türü seçin';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedLoadingCity,
                items: _cities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedLoadingCity = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Yükün Alınacağı İl'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen yükün alınacağı ili seçin';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedDestinationCity,
                items: _cities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedDestinationCity = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Yükün Gideceği İl'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen yükün gideceği ili seçin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addLoadPosting,
                child: Text('İlanı Ekle'),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Yük Miktarı (kg)'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _weight = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen yük miktarını girin';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Teslim Tarihi'),
                      readOnly: true,
                      controller: TextEditingController(
                          text: _selectedDate != null
                              ? _selectedDate.toString()
                              : ''),
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = DateTime(pickedDate.year,
                                pickedDate.month, pickedDate.day);
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen teslim tarihini seçin';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
