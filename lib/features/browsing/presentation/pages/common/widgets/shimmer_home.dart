import 'package:flutter/material.dart';
import 'package:kokorico/core/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/const.dart';

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
            Center(child: _buildShimmer(16, width * 0.60)),
            verticalSpacer(height: 6),
            Center(child: _buildShimmer(16, width * 0.40)),
            verticalSpacer(height: 20),
            // Swiper shimmer
            _buildShimmer(height * 0.35, double.infinity),
            verticalSpacer(),
            // Notre catalogue shimmer
            _buildShimmer(20, width * 0.60),
            verticalSpacer(height: 8),
            _buildShimmer(120, double.infinity),
            verticalSpacer(height: 8),
            _buildShimmer(120, double.infinity),
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
        baseColor: AppColors.cardColor.withOpacity(0.8),
        highlightColor: Colors.white,
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 3000),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
