import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/const.dart';
import '../common/widgets/custom_button.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late TextEditingController _quantityController;

  int _quantity = 1;

  @override
  initState() {
    super.initState();
    _quantityController = TextEditingController(text: _quantity.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.primaryColorDark,
            icon: const Icon(Icons.arrow_back_ios)),
        actions: const [
          // IconButton(
          //     onPressed: () {},
          //     color: AppColors.primaryColorDark,
          //     icon: const Icon(Icons.add_shopping_cart)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size(context).height * 0.35,
              color: AppColors.cardColor,
              child: Center(
                child: FancyShimmerImage(
                  imageUrl: widget.product.imageUrl,
                  boxFit: BoxFit.cover,
                  shimmerBaseColor: AppColors.primaryColor.withOpacity(0.25),
                  shimmerHighlightColor: Colors.white,
                  shimmerBackColor:
                      AppColors.primaryColorDark.withOpacity(0.40),
                ),
              ),
            ),
            verticalSpacer(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(widget.product.name,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.share_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart)),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(widget.product.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400))),
              ),
            ),
            verticalSpacer(height: 16),
            _buildItemDetials('Prix', '${widget.product.price} FC'),
            _buildItemDetials('Unité', widget.product.unit),
            _buildItemDetials(
                'Disponible', widget.product.isAvailable ? 'Oui' : 'Non'),
            verticalSpacer(height: 16),
            _buildQuantiteWidget(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: AppColors.primaryColor,
        child: Center(
            child: Text('Passer la commande',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)))),
      ),
    );
  }

  Widget _buildItemDetials(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(children: [
            Text(title,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))),
            const Spacer(),
            Text(value,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))),
          ]),
          const Divider(
            thickness: 1,
            color: Color(0XFFB89F83),
          )
        ],
      ),
    );
  }

  Widget _buildQuantiteWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text('Quantité',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))),
          const Spacer(),
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (_quantity == 1) return;
                      setState(() {
                        _quantity--;
                        _quantityController.text = _quantity.toString();
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 60,
                      color: AppColors.primaryColor,
                      child: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      // initialValue: _quantity.toString(),
                      textAlign: TextAlign.center,

                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _quantity = 1;
                          _quantityController.text = _quantity.toString();
                          return;
                        }
                        setState(() {
                          _quantity = int.parse(value);
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: AppColors.cardColor,
                        filled: true,
                        // labelText: '1',
                        // hintText: _quantity.toString(),

                        hintStyle: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _quantity++;
                        _quantityController.text = _quantity.toString();
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 60,
                      color: AppColors.primaryColor,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
