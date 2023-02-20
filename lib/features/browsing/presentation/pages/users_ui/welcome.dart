import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/const.dart';
import 'package:kokorico/core/helpers/routes.dart';

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
            Text("Bienvenue dans notre magasin",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500))),
            verticalSpacer(height: 36),
            _buildButton(
                text: 'Se connecter',
                textColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                onTap: () {
                  Routes.goTo(context, '/signin');
                }),
            verticalSpacer(height: 16),
            _buildButton(
                text: 'Créer un compte',
                textColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                onTap: () {
                  Routes.goTo(context, '/signup');
                }),
            const Spacer(),
          ],
        ),
      ),
    ));
  }

  Widget _buildButton(
      {required String text,
      required Color textColor,
      required Color backgroundColor,
      required Function() onTap}) {
    return Container(
      height: 50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ),
      ),
    );
  }
}
