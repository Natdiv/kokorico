import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/colors.dart';
import '../../../data/models/product_model.dart';
import '../../controllers/data_controller.dart';
import '../common/empty_widget.dart';
import '../common/widgets/shimmer_list.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final DataController _dataController = DataController();

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
      body: FutureBuilder(
          future: _dataController.getProducts(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Shimmer Home');
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
                  message: 'Aucune donnée disponible',
                  imageSrc: 'assets/images/no_data.svg',
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
                    message: 'Aucune donnée disponible',
                    imageSrc: 'assets/images/no_data.svg',
                  );
                }
                return _mainBody(data as List<ProductModel>);
              });
            }
          }),
    );
  }

  Widget _mainBody(List<ProductModel> data) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return AdminCardProduct(product: data[index]);
          }),
    ));
  }
}

class AdminCardProduct extends StatelessWidget {
  ProductModel product;

  AdminCardProduct({super.key, required this.product});
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
              child: FancyShimmerImage(
                imageUrl: product.imageUrl,
                boxFit: BoxFit.contain,
                shimmerBaseColor: AppColors.primaryColor.withOpacity(0.25),
                shimmerHighlightColor: Colors.white,
                shimmerBackColor: AppColors.primaryColorDark.withOpacity(0.40),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    Text('Prix: ${product.price} FC',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500))),
                    Text('Unité: ${product.unit}',
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
