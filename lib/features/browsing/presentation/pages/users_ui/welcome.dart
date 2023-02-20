import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/const.dart';
import '../../../../../core/helpers/routes.dart';
import '../widgets/custom_button.dart';

import '../../../../../core/theme/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
              'assets/images/welcome.svg',
              fit: BoxFit.fitHeight,
              height: size(context).height * 0.30,
            )),
            verticalSpacer(height: 36),
            Text("Bienvenue dans notre ferme",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500))),
            verticalSpacer(height: 36),
            CustomButton(
                text: 'Se connecter',
                textColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                onTap: () {
                  Routes.goTo(context, '/signin');
                }),
            verticalSpacer(height: 16),
            CustomButton(
                text: 'Créer un compte',
                textColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                onTap: () {
                  Routes.goTo(context, '/signup');
                }),
            const Spacer(),
            RichText(
              text: TextSpan(
                text: 'Se connecter plus tard',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Routes.goTo(context, '/home');
                  },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
