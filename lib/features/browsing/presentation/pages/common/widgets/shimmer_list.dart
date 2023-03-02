import 'package:flutter/material.dart';
import 'package:kokorico/core/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/const.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

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
            _buildShimmer(120, double.infinity),
            verticalSpacer(height: 8),
            _buildShimmer(120, double.infinity),
            verticalSpacer(height: 8),
            _buildShimmer(120, double.infinity),
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
