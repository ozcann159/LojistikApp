import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        _userData = documentSnapshot.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: _userData.isNotEmpty
          ? ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text('İsim'),
                  subtitle: Text(_userData['name'] ?? ''),
                ),
                ListTile(
                  title: Text('Soyisim'),
                  subtitle: Text(_userData['surname'] ?? ''),
                ),
                ListTile(
                  title: Text('E-posta'),
                  subtitle: Text(_userData['email'] ?? ''),
                ),
                ListTile(
                  title: Text('Kullanıcı Türü'),
                  subtitle: Text(_userData['userType'] ?? ''),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
