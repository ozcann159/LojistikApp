import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loadspotter/repositories/firestore_services.dart';

import '../blocs/shipper_registration/shipper_registration_bloc.dart';
import '../blocs/shipper_registration/shipper_registration_event.dart';
import '../blocs/shipper_registration/shipper_registration_state.dart';
import 'login_page.dart';

class ShipperRegistrationPage extends StatefulWidget {
  const ShipperRegistrationPage({Key? key}) : super(key: key);

  @override
  State<ShipperRegistrationPage> createState() =>
      _ShipperRegistrationPageState();
}

class _ShipperRegistrationPageState extends State<ShipperRegistrationPage> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShipperRegistrationBloc(FirestoreService()),
      child: ShipperRegistrationForm(),
    );
  }
}

class ShipperRegistrationForm extends StatefulWidget {
  @override
  _ShipperRegistrationFormState createState() =>
      _ShipperRegistrationFormState();
}

class _ShipperRegistrationFormState extends State<ShipperRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _cityController = TextEditingController();
  final _contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yük Taşıtan Kaydı'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _companyController,
                  decoration:
                      InputDecoration(labelText: 'Firma Adı veya Adınız'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen firma adını girin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'İl Seçiniz'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen il girin';
                    }
                    return null;
                  },
                ),
                IntlPhoneField(
                  focusNode: FocusNode(),
                  decoration: InputDecoration(labelText: 'İletişim Numarası'),
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  validator: (phone) {
                    if (phone?.number == null || phone!.number.isEmpty) {
                      return 'Lütfen iletişim numarasını girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<ShipperRegistrationBloc>(context).add(
                          SaveData(
                            _companyController.text,
                            _cityController.text,
                            _contactNumberController.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 45),
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
                BlocListener<ShipperRegistrationBloc, ShipperRegistrationState>(
                  listener: (context, state) {
                    if (state is ShipperRegistrationLoading) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kaydediliyor...')),
                      );
                    } else if (state is ShipperRegistrationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Yük taşıtan kaydı başarıyla tamamlandı')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else if (state is ShipperRegistrationFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Yük taşıtan kaydı başarısız oldu: ${state.error}')),
                      );
                    }
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
