import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/colors.dart';
import '../common/widgets/card_cart_product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: 6,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return const CardCartProduct();
            }),
      )),
      bottomNavigationBar: _buildBottomOfPage(context),
    );
  }

  Widget _buildBottomOfPage(BuildContext context) {
    final double height = size(context).height;
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
                      Text('22, 500 FC',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
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
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                      child: Center(
                        child: Text('Payer',
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
