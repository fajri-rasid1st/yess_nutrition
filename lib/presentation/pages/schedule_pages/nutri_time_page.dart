import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/data/models/schedule_models/data_menu_makan_nutritime.dart';
import 'package:yess_nutrition/presentation/pages/pages.dart';
import 'package:yess_nutrition/presentation/pages/schedule_pages/nutri_time_add_food_page.dart';

class NutriTimePage extends StatefulWidget {
  const NutriTimePage({Key? key}) : super(key: key);

  @override
  State<NutriTimePage> createState() => _NutriTimePagePageState();
}

class _NutriTimePagePageState extends State<NutriTimePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, alarmNutriTimePage);
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                children: const <Text>[
                  Text(
                    'Waktu Makan',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final DataMenuMakan menuMakan = dataWaktuMakan[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const AddFood();
                            }));
                          },
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
