import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/const.dart';
import '../../../../../../core/helpers/routes.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../data/models/product_model.dart';

class CardProduct extends StatelessWidget {
  final ProductModel product;

  const CardProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Routes.goTo(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: SizedBox(
          height: 140,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColorDark.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset:
                            const Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.name,
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))),
                          SizedBox(
                            width: size(context).width - 200,
                            child: Text(product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Prix: ',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  children: [
                                TextSpan(
                                    text: '${product.price} FC',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold))),
                                TextSpan(
                                    text: ' /par ${product.unit}',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)))
                              ])),
                        ]),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColorDark.withOpacity(0.25),
                        spreadRadius: 6,
                        blurRadius: 16,
                        offset:
                            const Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset('assets/images/chicken.png',
                      fit: BoxFit.fitHeight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
