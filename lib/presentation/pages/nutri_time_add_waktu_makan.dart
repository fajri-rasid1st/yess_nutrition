import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yess_nutrition/presentation/pages/nutri_time_page.dart';

import 'nutri_time_alarm_page.dart';

class AddWaktuMakanPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Text('NutriTime'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(children: [
              Text(
                'Atur Waktu Makan',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 200,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AlarmNutriTime();
                }));
              },
              child: Text('Sarapan'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 200,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AlarmNutriTime();
                }));
              },
              child: Text('Makan Siang'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 200,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AlarmNutriTime();
                }));
              },
              child: Text('Makan Malam'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
