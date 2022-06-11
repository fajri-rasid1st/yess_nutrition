import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class AlarmNutriTimePage extends StatefulWidget {
  const AlarmNutriTimePage({Key? key}) : super(key: key);

  @override
  State<AlarmNutriTimePage> createState() => _AlarmNutriTimePageState();
}

class _AlarmNutriTimePageState extends State<AlarmNutriTimePage> {
  late TextEditingController hourController;
  late TextEditingController minuteController;

  @override
  void initState() {
    hourController = TextEditingController();
    minuteController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Text('NutriTime'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            const Text(
              'Tentukan Alarm Waktu Makan',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextField(
                      controller: hourController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: secondaryBackgroundColor,
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
          ],
        ),
      ),
    );
  }
}
