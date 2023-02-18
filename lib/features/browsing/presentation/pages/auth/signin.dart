import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/const.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            SvgPicture.asset(
              'assets/logo/logo.svg',
              width: 150,
            ),
            verticalSpacer(height: 16),
            Text(
              'Connexion',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColorDark,
                      fontSize: 32,
                      fontWeight: FontWeight.w500)),
            ),
            Text(
              'Connectez-vous pour continuer',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.primaryColorDark.withOpacity(0.80),
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            const SizedBox(
              height: 36,
            ),
            _buildPhoneField(context),
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
                  onTap: () {
                    // Get.to(() => const SmsCodePage());
                    // setState(() {});
                  },
                  child: Center(
                    child: Text(
                      'Se connecter',
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
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Center(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Vous n\'avez pas de compte ? ',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: AppColors.primaryColorDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w400))),
                  TextSpan(
                      text: 'Créer un compte',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const SigninPage()));
                        },
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              // decoration: TextDecoration.underline,
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)))
                ])),
              ),
            ),
            Spacer()
          ],
        ),
      )),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          InkWell(
            onTap: () async {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '+243',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppColors.primaryColorDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 20,
              width: 1,
              color: AppColors.primaryColor,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              decoration: const InputDecoration(
                  hintText: 'Téléphone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  // border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }
}
