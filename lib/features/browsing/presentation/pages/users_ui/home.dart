import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/helpers/routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/const.dart';
import 'cart.dart';
import 'delivery.dart';
import 'notifications.dart';
import 'profil.dart';
import '../common/widgets/card_product.dart';
import '../common/widgets/home_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = const [
    HomePage(),
    CartPage(),
    NotificationsPage(),
    DeliveryPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: SizedBox(
            height: 24,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset('assets/logo/logo.svg'),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: AppColors.primaryColorDark,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacer(height: 12),
                _buidWelcomeText(),
                verticalSpacer(height: 0),
                const HomeSwiper(),
                verticalSpacer(),
                Text('Notre catalogue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                verticalSpacer(height: 8),
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const CardProduct();
                    }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar());
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: AppColors.primaryColor,
      height: 60,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomBarItem(Icons.home_filled, '/home'),
            _bottomBarItem(Icons.shopping_cart, '/cart'),
            _bottomBarItem(Icons.notifications, '/notifications'),
            _bottomBarItem(Icons.delivery_dining, '/delivery'),
            _bottomBarItem(Icons.person, '/profile'),
          ]),
    );
  }

  Widget _bottomBarItem(IconData icon, String route) {
    return IconButton(
        onPressed: () {
          Routes.goTo(context, route);
        },
        icon: Icon(
          icon,
          size: 25,
          color: route == '/home' ? AppColors.secondaryColor : Colors.white,
        ));
    ;
  }

  Widget _buidWelcomeText() {
    return Align(
      alignment: Alignment.center,
      child: Text('Récoltez la fraîcheur,\nGoutez la différence',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold))),
    );
  }
}
