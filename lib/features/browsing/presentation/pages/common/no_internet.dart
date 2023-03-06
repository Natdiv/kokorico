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
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: AppColors.primaryColorDark,
              icon: const Icon(Icons.arrow_back_ios)),
        ),
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
                Text("Veuillez vérifier votre connexion internet",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: AppColors.primaryColorDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w500))),
                verticalSpacer(height: 32),
                verticalSpacer(height: 16),
                CustomButton(
                    text: 'Réessayer',
                    textColor: AppColors.primaryColor,
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
