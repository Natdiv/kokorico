import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/theme/colors.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
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
      splashColor: AppColors.primaryColorDark,
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
