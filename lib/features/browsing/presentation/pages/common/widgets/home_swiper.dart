import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';

import '../../../../../../core/const.dart';
import '../../../../../../core/theme/colors.dart';

class HomeSwiper extends StatelessWidget {
  final List<ProductModel> data;

  const HomeSwiper({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final height = size(context).height;
    return SizedBox(
      height: height * 0.4,
      width: double.infinity,
      child: Swiper(
          itemWidth: height * 0.5,
          itemHeight: height * 0.4,
          scale: 0.9,
          layout: SwiperLayout.TINDER,
          autoplay: true,
          autoplayDelay: 5000,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: height * 0.48,
                width: height * 0.48,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: _buildCornerContainer(height * 0.3),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: _buildCornerContainer(height * 0.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              verticalSpacer(),
                              Text(data[index].name,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Expanded(
                                child: FancyShimmerImage(
                                  imageUrl: data[index].imageUrl,
                                  boxFit: BoxFit.contain,
                                  shimmerBaseColor:
                                      AppColors.primaryColor.withOpacity(0.25),
                                  shimmerHighlightColor: Colors.white,
                                  shimmerBackColor: AppColors.primaryColorDark
                                      .withOpacity(0.40),
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildCornerContainer(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
