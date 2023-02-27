import 'package:flutter/material.dart';
import 'package:kokorico/core/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/const.dart';

class ShimmerHome extends StatelessWidget {
  const ShimmerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return _mainBody(context);
  }

  Widget _mainBody(BuildContext context) {
    final height = size(context).height;
    final width = size(context).width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacer(height: 12),
            _buildShimmer(36, width * 0.60),
            verticalSpacer(height: 8),
            _buildShimmer(36, width * 0.40),
            verticalSpacer(height: 20),
            // Swiper shimmer
            _buildShimmer(height * 0.5, double.infinity),
            verticalSpacer(),
            // Notre catalogue shimmer
            _buildShimmer(36, width * 0.60),
            verticalSpacer(height: 8),
            _buildShimmer(140, double.infinity),
            verticalSpacer(height: 8),
            _buildShimmer(140, double.infinity),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!.withOpacity(0.8),
        highlightColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
