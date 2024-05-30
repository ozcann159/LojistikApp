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
 


  String? _selectedLicense;
  String? _selectedCertification;
  String? _selectedTruckOptions;

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
    'Kamyonet',
    'Çekici',
    'Tanker',
  ];

  Future<void> _saveDate() async {
    if (_formKey.currentState!.validate()) {
      String license = _selectedLicense!;
      String certification = _selectedCertification!;
      String truckType = _selectedTruckOptions!;

      try {
        await _firebaseService.saveDriverData(
            certification: certification,
            truckType: truckType,
            license: license);
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şoför Kaydı'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<String>(
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
                decoration: InputDecoration(
                  labelText: 'Ehliyet Bilgisi',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen ehliyet bilgisini seçin';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
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
              DropdownButtonFormField<String>(
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
                decoration: InputDecoration(labelText: 'Kamyon Tipi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Kamyon Tipini Seçin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveDate();
                  }
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
