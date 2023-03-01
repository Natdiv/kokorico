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
          const ListTileItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            selected: true,
            route: '/dashboard',
          ),
          const ListTileItem(
            title: 'Ajouter un article',
            icon: Icons.add,
            route: '/new-product',
          ),
          const ListTileItem(
            title: 'Les articles',
            icon: Icons.list,
            route: '/all-products',
          ),
          const ListTileItem(
            title: 'Les commandes',
            icon: Icons.shopping_bag_outlined,
            route: '/all-orders',
          ),
          const ListTileItem(
            title: 'Paiements',
            icon: Icons.payment_outlined,
            route: '/payments-received',
          ),
          const Spacer(),
          ListTile(
            title: Text('Mode admin',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
            horizontalTitleGap: 0,
            splashColor: AppColors.primaryColorDark,
            leading: const Icon(
              Icons.supervisor_account,
              color: AppColors.primaryColorDark,
            ),
            trailing: Switch(
              value: state.isModeAdmin,
              onChanged: (value) {
                state.setAdmiMode(() {
                  Phoenix.rebirth(context);
                });
              },
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            onTap: () {
              state.setAdmiMode(() {
                Phoenix.rebirth(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
