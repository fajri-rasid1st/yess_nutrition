import 'package:flutter/material.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';

import 'nutri_time_add_waktu_makan.dart';
import 'nutri_time_alarm_page.dart';

class NutriTimePage extends StatefulWidget {
  @override
  State<NutriTimePage> createState() => _NutriTimePagePageState();
}

class _NutriTimePagePageState extends State<NutriTimePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.0,
                  color: Color(0XFF7165E3),
                ),
                onPressed: () {}),
            Text(
              'NutriTime',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.notification_add_outlined,
                color: Color(0XFF7165E3),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddWaktuMakanPage()));
              },
            ),
          ],
        ),
      ]),
    );
  }
}
