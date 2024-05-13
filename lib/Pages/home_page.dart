import 'package:flutter/material.dart';
import 'package:loadspotter/widgets/body_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: Text(
            'Yük Dünyası',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
              color: Colors.white,
            )
          ],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Container(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/logo3.png',
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Anasayfa'),
                onTap: () {
                  Navigator.pop(
                      context); // Burada pop kullanarak drawer'ı kapatıyoruz
                },
              ),
              ListTile(
                leading: Icon(Icons.tab_sharp),
                title: Text('Yük İlanı ekle'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.fire_truck_sharp),
                title: Text('Araçlar'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.add_box),
                title: Text('Araç İlanı Ekle'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profil'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Bildirimler'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.support_agent_outlined),
                title: Text('Canlı Destek'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Çıkış Yap'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: BodyContent());
  }
}
