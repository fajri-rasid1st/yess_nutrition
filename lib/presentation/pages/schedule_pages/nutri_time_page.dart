import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/data/models/data_menu_makan_nutritime.dart';
import 'package:yess_nutrition/presentation/pages/schedule_pages/nutri_time_add_waktu_makan.dart';

class NutriTimePage extends StatefulWidget {
  const NutriTimePage({Key? key}) : super(key: key);

  @override
  State<NutriTimePage> createState() => _NutriTimePagePageState();
}

class _NutriTimePagePageState extends State<NutriTimePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20.0,
                  color: primaryColor,
                ),
                onPressed: () {},
              ),
              const Text(
                'NutriTime',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.notification_add_outlined,
                  color: Color(0XFF7165E3),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddWaktuMakanPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(children: const [
              Text(
                'Waktu Makan',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      menuMakan.waktuMakan,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
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
              ))
            ],
          ),
        ],
      ),
    );
  }
}
