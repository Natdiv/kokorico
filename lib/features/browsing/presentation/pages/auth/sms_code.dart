import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/features/browsing/presentation/pages/common/loading_page.dart';
// import 'package:kokorico/features/browsing/presentation/pages/widgets/loading_page.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/colors.dart';
import 'package:pinput/pinput.dart';

import '../../state/auth_state.dart';

class SmsCodePage extends StatelessWidget {
  SmsCodePage({super.key});

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context, listen: false);
    return state.isbusy ? const LoadingScreen() : _smsCodeScreen(context);
  }

  Widget _smsCodeScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Text(
                'Confirmation',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 32,
                        fontWeight: FontWeight.w500)),
              ),
              Text(
                'Entrez le code de confirmation envoyé à votre numéro de téléphone',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: AppColors.primaryColorDark.withOpacity(0.80),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 32,
              ),
              _buidPinputWidget(context),
              const SizedBox(
                height: 32,
              ),
              Container(
                height: 50,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Confirmer',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      )),
    );
  }

  Widget _buidPinputWidget(BuildContext context) {
    final state = Provider.of<AuthState>(context, listen: false);
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
              color: AppColors.primaryColorDark,
              fontSize: 24,
              fontWeight: FontWeight.bold)),
      decoration: const BoxDecoration(color: AppColors.cardColor),
    );

    final focusedPinTheme = PinTheme(
        width: 50,
        height: 50,
        textStyle: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        decoration: BoxDecoration(color: Colors.grey[100]));

    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Pinput(
          length: 6,
          controller: pinController,
          focusNode: focusNode,
          separator: Container(
            height: 50,
            width: 1,
            color: Colors.white,
          ),
          onCompleted: (String value) {
            // signInWithPhoneNumber(context, value);
            Navigator.pop<String>(context, value);
          },
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          showCursor: true,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          animationCurve: Curves.easeInOut,
          pinAnimationType: PinAnimationType.rotation,
          hapticFeedbackType: HapticFeedbackType.vibrate,
        ),
      ),
    );
  }

  // signInWithPhoneNumber(BuildContext context, String smsCode) async {
  //   final state = Provider.of<AuthState>(context, listen: false);
  //   var verificationId = state.verificationId;

  //   state.signinWithPhone(verificationId, smsCode);
  // }
}
