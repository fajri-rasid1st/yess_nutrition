import 'package:flutter/material.dart';
import 'package:yess_nutrition/data/models/data_menu_makan_nutritime.dart';
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
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0),
          child: Row(children: [
            Text(
              'Waktu Makan',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final DataMenuMakan menuMakan = dataWaktuMakan[index];
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        menuMakan.waktuMakan,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(menuMakan.info),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: dataWaktuMakan.length,
                  ),
                ),
              ))
            ],
          ),
        ),
      ]),
    );
  }
}
