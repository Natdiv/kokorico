import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/colors.dart';
import '../../state/auth_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mon Profil',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.primaryColorDark,
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {},
              color: AppColors.primaryColorDark,
              icon: const Icon(Icons.menu_outlined)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                verticalSpacer(height: 16),
                _buildCardInfo(
                    title: 'Nom Complet',
                    value:
                        '${state.appUser!.firstName} ${state.appUser!.name}'),
                _buildCardInfo(
                    title: 'Numero', value: state.appUser!.phoneNumber),
                _buildCardInfo(title: 'Email', value: state.appUser!.email),
                _buildCardInfo(
                    title: 'Adresse de livraison',
                    value: state.appUser!.address),
                _buildCardInfo(
                    title: 'Référence',
                    value: state.appUser!.referenceAddress ?? 'Non renseigné'),
                verticalSpacer(height: 8),
                _buildProfileActionButton(
                    title: 'Modifier mon compte',
                    color: AppColors.primaryColor),
                verticalSpacer(height: 8),
                _buildProfileActionButton(
                    title: 'Supprimer mon compte', color: Colors.redAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileActionButton(
      {required String title, required Color color}) {
    return Container(
      height: 42,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Text(title,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))),
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))),
            verticalSpacer(height: 8),
            Text(value,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
          ]),
        ),
      ),
    );
  }
}
