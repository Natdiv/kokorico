import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/theme/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
          DrawerListTile(
            title: 'Dashboard',
            icon: Icons.dashboard,
            press: () {},
          ),
          DrawerListTile(
            title: 'Ajouter un article',
            icon: Icons.add,
            press: () {},
          ),
          DrawerListTile(
            title: 'Les articles',
            icon: Icons.list,
            press: () {},
          ),
          DrawerListTile(
            title: 'Les commandes',
            icon: Icons.shopping_bag_outlined,
            press: () {},
          ),
          DrawerListTile(
            title: 'Paiements',
            icon: Icons.payment_outlined,
            press: () {},
          ),
          const Spacer(),
          DrawerListTile(
            title: 'Mode admin',
            icon: Icons.supervisor_account,
            press: () {},
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
    this.trailing,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: AppColors.primaryColorDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w500))),
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: AppColors.primaryColorDark,
      ),
      trailing: (trailing != null) ? trailing : null,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      onTap: press,
    );
  }
}
