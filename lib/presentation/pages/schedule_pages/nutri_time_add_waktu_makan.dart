import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/presentation/pages/schedule_pages/nutri_time_alarm_page.dart';

class AddWaktuMakanPage extends StatelessWidget {
  const AddWaktuMakanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: primaryBackgroundColor,
          ),
          onPressed: () {},
        ),
        title: const Text('NutriTime'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: const <Widget>[
                Text(
                  'Atur Waktu Makan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: 200,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const AlarmNutriTimePage();
                  }),
                );
              },
              child: const Text('Sarapan'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: 200,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const AlarmNutriTimePage();
                  }),
                );
              },
              child: const Text('Makan Siang'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: 200,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const AlarmNutriTimePage();
                  }),
                );
              },
              child: const Text('Makan Malam'),
            ),
          ),
        ],
      ),
    );
  }
}
