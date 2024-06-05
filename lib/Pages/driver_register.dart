import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/login_page.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

class DriverRegistrationPage extends StatefulWidget {
  const DriverRegistrationPage({Key? key}) : super(key: key);

  @override
  _DriverRegistrationPageState createState() => _DriverRegistrationPageState();
}

class _DriverRegistrationPageState extends State<DriverRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseService = FirebaseService();

  String? _carPlate;
  String? _vehicleBrand;
  String? _caseType;
  String? _selectedLicense;
  String? _selectedCertification;
  String? _selectedTruckOptions;

  bool _isLoading = false;

  List<String> licenseOptions = [
    'Ehliyet A',
    'Ehliyet B',
    'Ehliyet C',
    'Ehliyet D',
    'Ehliyet E'
  ];

  List<String> certificationOptions = [
    'ADR (Tehlikeli Madde Taşımacılığı)',
    'SRC (Sürücü Belgesi)',
    'İlk Yardım Sertifikası',
    'Araç Bakım ve Onarım Sertifikası'
  ];

  List<String> truckOptions = [
    'Kamyon',
    'Tır',
    '8 Teker Kamyon',
    'Kırkayak',
    'Tır - Kısadorse',
    'Kamyonet',
    'Çekici',
    'Tanker',
  ];

  Future<void> _saveDate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String license = _selectedLicense!;
      String certification = _selectedCertification!;
      String truckType = _selectedTruckOptions!;
      String carPlate = _carPlate!;

      try {
        await _firebaseService.saveDriverData(
          certification: certification,
          truckType: truckType,
          license: license,
          carPlate: carPlate,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Şoför kaydı başarıyla tamamlandı'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Şoför kaydı başarısız oldu: $e"),
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sürücü Bilgileri'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Icon(CupertinoIcons.doc_plaintext),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedLicense,
                        items: licenseOptions.map((String license) {
                          return DropdownMenuItem<String>(
                            value: license,
                            child: Text(license),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLicense = newValue;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Ehliyet Bilgisi',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen ehliyet bilgisini seçin';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.square_favorites),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCertification,
                        items: certificationOptions.map((String certification) {
                          return DropdownMenuItem<String>(
                            value: certification,
                            child: Text(certification),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCertification = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Sertifikalar',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.fire_truck_outlined),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedTruckOptions,
                        items: truckOptions.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedTruckOptions = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Kamyon Tipi',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Kamyon Tipini Seçin';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Araç Plakası',
                    icon: Icon(CupertinoIcons.hexagon),
                  ),
                  onChanged: (value) {
                    _carPlate = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen araç plakasını giriniz';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Center(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveDate();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: Colors.blue.shade600),
                          child: const Text(
                            'Kaydet',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
