import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/theme/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/helpers/routes.dart';
import '../../../state/app_state.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.route,
    this.trailing,
    this.selected,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget? trailing;
  final String route;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context, listen: false);
    return ListTile(
      title: Text(title,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: AppColors.primaryColorDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w500))),
      horizontalTitleGap: 0,
      selected: selected ?? false,
      selectedTileColor: AppColors.cardColor,
      splashColor: AppColors.primaryColorDark,
      leading: Icon(
        icon,
        color: AppColors.primaryColorDark,
      ),
      trailing: (trailing != null) ? trailing : null,
      onTap: () {
        state.scaffoldKey.currentState!.openEndDrawer();
        Routes.goTo(context, route);
      },
    );
  }
}
