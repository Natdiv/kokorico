import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/helpers/routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/const.dart';
import '../../controllers/data_controller.dart';
import '../common/empty_widget.dart';
import '../common/widgets/shimmer_home.dart';
import '../common/widgets/card_product.dart';
import '../common/widgets/home_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataController _dataController = DataController();

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
        body: FutureBuilder(
            future: _dataController.getProducts(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('Shimmer Home');
                return const ShimmerHome();
              } else {
                if (snapshot.hasError) {
                  print('Has Error');
                  return const EmptyWidget(
                    message: 'Une erreur est survenue',
                    imageSrc: 'assets/images/cancel.svg',
                  );
                } else if (snapshot.data == null) {
                  print('Has No Data');
                  return const EmptyWidget(
                    message: 'Aucune donnée disponible',
                    imageSrc: 'assets/images/no_data.svg',
                  );
                }
                print('All Data');
                final result = snapshot.data;
                return result!.fold((failure) {
                  return EmptyWidget(
                    message: failure.props.first.toString(),
                    imageSrc: 'assets/images/cancel.svg',
                  );
                }, (data) {
                  if (data.isEmpty) {
                    return const EmptyWidget(
                      message: 'Aucune donnée disponible',
                      imageSrc: 'assets/images/no_data.svg',
                    );
                  }
                  return _mainBody(data as List<ProductModel>);
                });
              }
            }),
        bottomNavigationBar: _buildBottomNavBar());
  }

  Widget _mainBody(List<ProductModel> data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacer(height: 12),
            _buidWelcomeText(),
            verticalSpacer(height: 0),
            HomeSwiper(
              data: data,
            ),
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
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CardProduct(product: data[index]);
                }),
          ],
        ),
      ),
    );
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
