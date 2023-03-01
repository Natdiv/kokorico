import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../state/auth_state.dart';
import 'liste_tile_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context, listen: false);
    return Drawer(
      // key: key,
      backgroundColor: AppColors.backgroundColor,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: SvgPicture.asset(
                'assets/logo/logo.svg',
                width: 120,
              ),
            ),
          ),
          ListTileItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            press: () {},
          ),
          ListTileItem(
            title: 'Ajouter un article',
            icon: Icons.add,
            press: () {},
          ),
          ListTileItem(
            title: 'Les articles',
            icon: Icons.list,
            press: () {},
          ),
          ListTileItem(
            title: 'Les commandes',
            icon: Icons.shopping_bag_outlined,
            press: () {},
          ),
          ListTileItem(
            title: 'Paiements',
            icon: Icons.payment_outlined,
            press: () {},
          ),
          const Spacer(),
          ListTileItem(
            title: 'Mode admin',
            icon: Icons.supervisor_account,
            press: () {
              state.setAdmiMode(() {
                Phoenix.rebirth(context);
              });
            },
            trailing: Switch(
              value: state.isModeAdmin,
              onChanged: (value) {
                state.setAdmiMode(() {
                  Phoenix.rebirth(context);
                });
              },
              activeColor: AppColors.primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}
