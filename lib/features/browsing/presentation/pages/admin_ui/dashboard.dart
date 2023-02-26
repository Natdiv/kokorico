import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/const.dart';
import '../common/widgets/drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dashboard',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            color: AppColors.primaryColorDark,
            icon: const Icon(Icons.menu)),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resumé de la journée',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))),
            verticalSpacer(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
              children: const [
                DashboardResumeItem(
                  title: 'Commandes',
                  value: '20',
                  icon: Icons.shopping_bag_outlined,
                ),
                DashboardResumeItem(
                  title: 'Livraisons',
                  value: '17',
                  icon: Icons.local_shipping_outlined,
                ),
                DashboardResumeItem(
                  title: 'Receptions',
                  value: '180.00',
                  icon: Icons.attach_money_outlined,
                ),
                DashboardResumeItem(
                  title: 'Nouveaux clients',
                  value: '4',
                  icon: Icons.person,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DashboardResumeItem extends StatelessWidget {
  const DashboardResumeItem({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColorDark.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon,
                      color: AppColors.secondaryColor.withOpacity(0.5),
                      size: 24),
                  const SizedBox(width: 8),
                  Text(value.toString(),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: AppColors.primaryColorDark,
                              fontSize: 24,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            verticalSpacer(height: 8),
            Text(title,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: AppColors.primaryColorDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))),
          ],
        ),
      ),
    );
  }
}
