import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_nutrients_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class NutrientsDetailPage extends StatefulWidget {
  final String uid;

  const NutrientsDetailPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<NutrientsDetailPage> createState() => _NutrientsDetailPageState();
}

class _NutrientsDetailPageState extends State<NutrientsDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<UserNutrientsNotifier>(context, listen: false)
          .readUserNutrients(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'Nutrisi Harian',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          tooltip: 'Back',
        ),
        actions: <IconButton>[
          IconButton(
            onPressed: () {},
            icon: const Icon(MdiIcons.clipboardEditOutline),
            tooltip: 'Edit',
          )
        ],
      ),
      body: Consumer<UserNutrientsNotifier>(
        builder: ((context, userNutrientsNotifier, child) {
          if (userNutrientsNotifier.state == RequestState.success) {}

          if (userNutrientsNotifier.state == RequestState.error) {}

          return Container(
            color: primaryBackgroundColor,
            child: const LoadingIndicator(),
          );
        }),
      ),
    );
  }

  Padding _buildDetailNutrientsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: primaryBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(0.0, 0.0),
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Detail Nutrisi Harian',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildNutrientIndicator(context),
              const SizedBox(height: 16),
              Divider(color: dividerColor.withOpacity(0.6)),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Reset Progress',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: primaryColor,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildNutrientIndicator(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Kalori',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          "4 dari 8",
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: secondaryTextColor),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: LinearPercentIndicator(
            lineHeight: 8,
            percent: 4 / 8,
            animation: true,
            animationDuration: 1000,
            progressColor: primaryColor,
            backgroundColor: secondaryColor,
            barRadius: const Radius.circular(10),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  // Container _buildPageError(UserNutrientsNotifier notifier) {
  //   return Container(
  //     color: primaryBackgroundColor,
  //     child: CustomInformation(
  //       key: const Key('error_message'),
  //       imgPath: 'assets/svg/error_robot_cuate.svg',
  //       title: notifier.message,
  //       subtitle: 'Silahkan coba beberapa saat lagi.',
  //       child: ElevatedButton.icon(
  //         onPressed: notifier.isReload
  //             ? null
  //             : () {
  //                 // set isReload to true
  //                 notifier.isReload = true;

  //                 Future.wait([
  //                   // create one second delay
  //                   Future.delayed(const Duration(seconds: 1)),

  //                   // refresh page
  //                   notifier.refresh(),
  //                 ]).then((_) {
  //                   // set isReload to true
  //                   notifier.isReload = false;
  //                 });
  //               },
  //         icon: notifier.isReload
  //             ? const SizedBox(
  //                 width: 18,
  //                 height: 18,
  //                 child: CircularProgressIndicator(
  //                   strokeWidth: 2,
  //                   color: dividerColor,
  //                 ),
  //               )
  //             : const Icon(Icons.refresh_rounded),
  //         label: notifier.isReload
  //             ? const Text('Tunggu sebentar...')
  //             : const Text('Coba lagi'),
  //       ),
  //     ),
  //   );
  // }
}
