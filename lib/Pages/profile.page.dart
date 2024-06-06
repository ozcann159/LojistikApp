import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  // void _signOut(BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     Navigator.of(context).pushNamedAndRemoveUntil('/giris', (route) => false);
  //   } catch (e) {
  //     print("Çıkış yaparken hata oluştu $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _userData.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.all(16.0),
                    children: [
                      ListTile(
                        leading: Icon(CupertinoIcons.person),
                        title: Text('İsim'),
                        subtitle: Text(_userData['name'] ?? ''),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.person),
                        title: Text('Soyisim'),
                        subtitle: Text(_userData['surname'] ?? ''),
                      ),
                      ListTile(
                        leading: Icon(CupertinoIcons.envelope),
                        title: Text('E-posta'),
                        subtitle: Text(_userData['email'] ?? ''),
                      ),
                      ListTile(
                        leading: Icon(Icons.work),
                        title: Text('Kullanıcı Türü'),
                        subtitle: Text(_userData['userType'] ?? ''),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 70, horizontal: 50),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       _signOut(context);
          //     },
          //     child: Text('Çıkış Yap'),
          //   ),
          // )
        ],
      ),
    );
  }
}
