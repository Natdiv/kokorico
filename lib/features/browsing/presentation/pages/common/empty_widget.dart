import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/const.dart';

class EmptyWidget extends StatelessWidget {
  final String imageSrc;
  final String message;

  const EmptyWidget({super.key, required this.message, required this.imageSrc});

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
              imageSrc,
              fit: BoxFit.fitHeight,
              height: size(context).height * 0.30,
            )),
            verticalSpacer(height: 36),
            Text(message,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500))),
            const Spacer(),
            verticalSpacer(height: 16),
            // CustomButton(
            //     text: 'Créer un compte',
            //     textColor: AppColors.primaryColor,
            //     backgroundColor: Colors.white,
            //     onTap: () {
            //       Routes.goTo(context, '/signup');
            //     }),
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
