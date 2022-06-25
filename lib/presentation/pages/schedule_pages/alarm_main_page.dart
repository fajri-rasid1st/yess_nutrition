import 'package:flutter/material.dart';
import 'package:yess_nutrition/presentation/pages/pages.dart';

class AlarmNutriTime extends StatelessWidget {
  const AlarmNutriTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm NutriTime',
      theme: ThemeData(
        colorSchemeSeed: Color(0XFF7165E3),
      ),
      home: AlarmNutriTimePage(),
    );
  }
}
