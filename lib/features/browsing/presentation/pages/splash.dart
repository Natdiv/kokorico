import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kokorico/core/theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SvgPicture.asset(
          'assets/logo/logo.svg',
          width: 120,
        ),
        const CircularProgressIndicator(
          color: AppColors.primaryColorDark,
        ),
      ],
    ));
  }
}
