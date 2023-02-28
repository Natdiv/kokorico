import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/helpers/routes.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/colors.dart';
import '../../state/auth_state.dart';
import '../common/loading_page.dart';
import 'sms_code.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late TextEditingController _phoneController;
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  String errorText = '';

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    focusNode.requestFocus();
  }

  @override
  dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);

    return state.isbusy ? const LoadingScreen() : _signinPage(context);
  }

  Widget _signinPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.primaryColorDark,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
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
                  height: 32,
                ),
                _buildPhoneField(context),
                Text(errorText,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 73, 52),
                            fontSize: 12,
                            fontWeight: FontWeight.w400))),
                const SizedBox(
                  height: 16,
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
                        if (formKey.currentState!.validate()) {
                          _signinUser(context);
                        }
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
                  height: 24,
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
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Text(
            '+243',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
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
              focusNode: focusNode,
              controller: _phoneController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              minLines: 1,
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

  _signinUser(BuildContext context) async {
    var value = _phoneController.text.trim();

    final state = Provider.of<AuthState>(context, listen: false);

    if (value.isEmpty) {
      setState(() {
        errorText = 'Veuillez saisir votre numero';
      });
    } else if (value.length != 9) {
      setState(() {
        errorText =
            'Votre numero doit contenir au moins 9 chiffres\n(ex: 97 222 22 22)';
      });
    } else if (!'+243$value'.isPhoneNumber) {
      setState(() {
        errorText = 'Ce numero est invalide';
      });
    } else {
      await state.verifyPhoneNumber(context, '+243$value', pop: _pop);
    }
  }

  void _pop() {
    Navigator.pop(context);
  }
}
