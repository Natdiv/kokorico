import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/const.dart';
import '../../../../../../core/theme/colors.dart';
import 'custom_button.dart';

class SuccessOrFailureWidget extends StatelessWidget {
  final bool successOrFailure;
  final String message;
  final String textButton;
  final Function onTap;

  const SuccessOrFailureWidget(
      {super.key,
      required this.message,
      required this.onTap,
      required this.successOrFailure,
      required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            Icon(
              successOrFailure ? Icons.check_circle_outline : Icons.error,
              color: successOrFailure
                  ? AppColors.secondaryColor
                  : Colors.redAccent,
              size: 40,
            ),
            verticalSpacer(height: 36),
            Center(
              child: Text(message,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppColors.primaryColorDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w500))),
            ),
            verticalSpacer(height: 16),
            CustomButton(
                text: textButton,
                textColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                onTap: onTap()),
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
