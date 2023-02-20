import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/const.dart';
import '../../../../../core/theme/colors.dart';

class HomeSwiper extends StatelessWidget {
  const HomeSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final height = size(context).height;
    return SizedBox(
      height: height * 0.5,
      width: double.infinity,
      child: Swiper(
          itemWidth: height * 0.5,
          itemHeight: height * 0.5,
          scale: 0.9,
          layout: SwiperLayout.TINDER,
          autoplay: true,
          autoplayDelay: 4000,
          itemCount: 5,
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
                              Text('Poulet sur patte',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )),
                              Expanded(
                                  child:
                                      Image.asset('assets/images/chicken.png'))
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
