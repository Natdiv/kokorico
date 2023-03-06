import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/helpers/utility.dart';
import 'package:provider/provider.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/colors.dart';
import '../../state/auth_state.dart';
import '../common/widgets/liste_tile_item.dart';

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
                    value: '${state.appUser!.firstName} ${state.appUser!.name}',
                    icon: Icons.person_outline),
                _buildCardInfo(
                    title: 'Numero',
                    value: state.appUser!.phoneNumber,
                    icon: Icons.phone),
                _buildCardInfo(
                    title: 'Email',
                    value: state.appUser!.email,
                    icon: Icons.email),
                _buildCardInfo(
                    title: 'Adresse de livraison',
                    value: state.appUser!.address,
                    icon: Icons.home),
                _buildCardInfo(
                    title: 'Référence',
                    value: state.appUser!.referenceAddress ?? 'Non renseigné',
                    icon: Icons.help),
                // const Spacer(),
                verticalSpacer(height: 32),

                if (state.appUser!.role != UserRole.USER)
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text('Le mode admin',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: AppColors.primaryColorDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500))),
                      horizontalTitleGap: 0,
                      splashColor: AppColors.primaryColorDark,
                      leading: const Icon(
                        Icons.admin_panel_settings,
                        color: AppColors.primaryColorDark,
                      ),
                      trailing: Switch(
                        value: state.isModeAdmin,
                        onChanged: (value) {},
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onTap: () {
                        state.setAdmiMode(() {
                          Phoenix.rebirth(context);
                        });
                      },
                    ),
                  ),
                verticalSpacer(height: 8),
                Container(
                    decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text('Se déconnecter',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: AppColors.primaryColorDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500))),
                      horizontalTitleGap: 0,
                      splashColor: AppColors.primaryColorDark,
                      leading: const Icon(
                        Icons.logout,
                        color: AppColors.primaryColorDark,
                      ),
                      // trailing: (trailing != null) ? trailing : null,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onTap: () {
                        state.logoutCallback();
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _builDivider() => Divider(
  //       thickness: 1,
  //       color: AppColors.primaryColor.withOpacity(0.25),
  //     );

  Widget _buildCardInfo(
      {required String title, required String value, required IconData icon}) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryColor, size: 24),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryColorDark,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))),
                        verticalSpacer(height: 0),
                        Text(value,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryColorDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
                      ]),
                ),
              ],
            ),
            verticalSpacer(height: 4),
            Divider(
              thickness: 1,
              color: AppColors.primaryColor.withOpacity(0.25),
            )
          ],
        ),
      ),
    );
  }
}
