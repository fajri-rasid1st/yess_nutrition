import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;

  const LoadingIndicator({Key? key, this.size = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: secondaryBackgroundColor,
        duration: const Duration(milliseconds: 1500),
        size: size,
      ),
    );
  }
}
