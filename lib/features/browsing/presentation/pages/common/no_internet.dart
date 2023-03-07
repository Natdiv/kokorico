import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/colors.dart';
import 'widgets/custom_button.dart';

class NoInternetConnexion extends StatelessWidget {
  const NoInternetConnexion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
                child: SvgPicture.asset(
              'assets/images/cancel.svg',
              fit: BoxFit.fitWidth,
              height: size(context).width * 0.40,
            )),
            verticalSpacer(height: 32),
            Text("Oh Ohhhhhh!",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
            Text("Veuillez vérifier votre connexion internet",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
            const Spacer(),
            CustomButton(
                text: 'Réessayer',
                textColor: AppColors.primaryColorDark,
                backgroundColor: Colors.white,
                onTap: () {
                  Phoenix.rebirth(context);
                }),
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
