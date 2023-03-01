import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/colors.dart';
import '../common/widgets/card_cart_product.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Liste de produits',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.primaryColorDark,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: 6,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return const AdminCardProduct();
            }),
      )),
    );
  }
}

class AdminCardProduct extends StatelessWidget {
  const AdminCardProduct({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 112,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColorDark.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Container(
              width: 112,
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/chicken.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Poulets sur pied',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    Text('Prix: 7, 500 FC',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500))),
                    Text('Unité: Kg',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
