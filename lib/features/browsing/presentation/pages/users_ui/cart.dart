import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kokorico/core/helpers/routes.dart';
import 'package:kokorico/features/browsing/presentation/pages/common/widgets/shimmer_list.dart';
import 'package:provider/provider.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/colors.dart';
import '../../../data/models/product_model.dart';
import '../../controllers/data_controller.dart';
import '../../state/cart_state.dart';
import '../common/empty_widget.dart';
import '../common/widgets/card_cart_product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final DataController _dataController = DataController();
  var f = NumberFormat.simpleCurrency(name: '', decimalDigits: 0);
  @override
  Widget build(BuildContext context) {
    var cartState = Provider.of<CartState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        centerTitle: true,
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
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: (cartState.getCart.isEmpty)
          ? const EmptyWidget(
              message: 'Votre panier est vide',
              imageSrc: 'assets/images/empty_cart.svg',
            )
          : FutureBuilder(
              future: _dataController.getCart(cartState.getCart),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('Shimmer Cart');
                  return const ShimmerList();
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
                      message: 'Votre panier est vide',
                      imageSrc: 'assets/images/empty_cart.svg',
                    );
                  }
                  final result = snapshot.data;
                  return result!.fold((failure) {
                    return EmptyWidget(
                      message: failure.props.first.toString(),
                      imageSrc: 'assets/images/cancel.svg',
                    );
                  }, (data) {
                    if (data.isEmpty) {
                      return const EmptyWidget(
                        message: 'Votre panier est vide',
                        imageSrc: 'assets/images/empty_cart.svg',
                      );
                    }
                    return _mainBody(data as List<ProductModel>);
                  });
                }
              }),
      bottomNavigationBar:
          (cartState.getCart.isEmpty) ? null : _buildBottomOfPage(context),
    );
  }

  Widget _mainBody(List<ProductModel> data) {
    var cartState = Provider.of<CartState>(context);
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return CardCartProduct(
                product: data[index],
                quantity: cartState.getQuantity(data[index].id!));
          }),
    ));
  }

  Widget _buildBottomOfPage(BuildContext context) {
    final double height = size(context).height;
    var cartState = Provider.of<CartState>(context, listen: false);
    return Container(
        height: height * 0.2,
        decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border:
                        Border.all(color: Color.fromARGB(255, 236, 197, 143))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total  à payer',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500))),
                      (cartState.getCart.isEmpty)
                          ? Text('---- 0 FC',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))
                          : FutureBuilder(
                              future:
                                  _dataController.getCart(cartState.getCart),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  double total = cartState.getTotalPrice(
                                      snapshot.data!.fold((l) => [], (r) => r));
                                  return Text('${f.format((total.round()))} FC',
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)));
                                }
                                return Text('--- ---',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)));
                              }),
                    ],
                  ),
                ),
              ),
              verticalSpacer(height: 16),
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      Routes.goTo(context, '/order', args: [true]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                      child: Center(
                        child: Text('Passer la commande',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
