import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';

class SchedulePage extends StatefulWidget {
  final String uid;

  const SchedulePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<SchedulePage> createState() => _NutriTimePagePageState();
}

class _NutriTimePagePageState extends State<SchedulePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 86,
        elevation: 0,
        title: const Text(
          'NutriTime',
          style: TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      scheduleAlarmRoute,
                      arguments: widget.uid,
                    ),
                    icon: const Icon(Icons.schedule_outlined),
                    color: primaryColor,
                    tooltip: 'Notification',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
