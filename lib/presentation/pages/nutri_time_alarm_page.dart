import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/presentation/pages/nutri_time_add_waktu_makan.dart';

import 'nutri_time_page.dart';

class AlarmNutriTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm NutriTime',
      theme: ThemeData(
        colorSchemeSeed: Color(0XFF7165E3),
      ),
      home: AlarmPage(),
    );
  }
}

class AlarmPage extends StatefulWidget {
  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  @override
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
        title: Text('NutriTime'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: <Widget>[
        SizedBox(height: 15),
        Text(
          'Tentukan Alarm Waktu Makan',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 182, 177, 228),
                  borderRadius: BorderRadius.circular(11)),
              child: Center(
                child: TextField(
                  controller: hourController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(width: 20),
            Container(
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 182, 177, 228),
                  borderRadius: BorderRadius.circular(11)),
              child: Center(
                child: TextField(
                  controller: minuteController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(25),
          child: TextButton(
            child: const Text(
              'Buat alarm',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              int hour;
              int minutes;
              hour = int.parse(hourController.text);
              minutes = int.parse(minuteController.text);

              // creating alarm after converting hour
              // and minute into integer
              FlutterAlarmClock.createAlarm(hour, minutes);
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // show alarm
            FlutterAlarmClock.showAlarms();
          },
          child: const Text(
            'Lihat Alarm',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ])),
    );
  }
}
