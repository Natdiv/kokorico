import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController _nameController;
  late TextEditingController _firstNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _adresseController;
  late TextEditingController _referenceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _firstNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _adresseController = TextEditingController();
    _referenceController = TextEditingController();
  }

  @override
  dispose() {
    _nameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _adresseController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 42,
              ),
              Text(
                'Inscription',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 32,
                        fontWeight: FontWeight.w500)),
              ),
              Text(
                'Créez un compte pour continuer',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: AppColors.primaryColorDark.withOpacity(0.80),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 36,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: 'Nom',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: 'Prénom',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 2,
                controller: _adresseController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    hintText: 'Adresse de livraison',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _referenceController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: 'Référence',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              const SizedBox(
                height: 12,
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
                        'S\'inscrire',
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
                        text: 'Vous avez déjà un compte ? ',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: AppColors.primaryColorDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w400))),
                    TextSpan(
                        text: 'Se connecter',
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
            ],
          ),
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
