import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Aktif olan endeksi belirtir
        onTap: (int index) {
          // Seçilen endekse göre işlem yapabilirsiniz
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab_sharp),
            label: 'Yük İlanı Ekle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck_sharp),
            label: 'Araçlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
