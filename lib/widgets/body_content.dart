import 'package:flutter/material.dart';

class BodyContent extends StatefulWidget {
  const BodyContent({Key? key}) : super(key: key);

  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  String selectedStart = 'Seçiniz';
  String selectedEnd = 'Seçiniz';
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedStart,
              onChanged: (String? newValue) {
                setState(() {
                  selectedStart = newValue!;
                });
              },
              items: <String>['Seçiniz', 'İstanbul', 'Ankara', 'İzmir']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedEnd,
              onChanged: (String? newValue) {
                setState(() {
                  selectedEnd = newValue!;
                });
              },
              items: <String>['Seçiniz', 'İstanbul', 'Ankara', 'İzmir']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                // Yük seçimi yapıldı, işlemleri burada gerçekleştirin
              },
              child: Text('Yük Seç'),
            ),
          ],
        ));
  }
}
