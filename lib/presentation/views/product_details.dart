import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/colors.dart';
import 'package:kokorico/core/const.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

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
        actions: [
          IconButton(
              onPressed: () {},
              color: AppColors.primaryColorDark,
              icon: const Icon(Icons.add_shopping_cart)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size(context).height * 0.35,
              color: AppColors.cardColor,
              child: Center(
                  child: Image.asset('assets/images/chicken.png',
                      fit: BoxFit.cover)),
            ),
            verticalSpacer(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text('Le coq',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.share_outlined)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('details' * 100,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400))),
            ),
            verticalSpacer(height: 16),
            _buildItemDetials('Prix', '12, 000 FC'),
            _buildItemDetials('Unité', '1 Kg'),
            _buildItemDetials('Disponible', 'Oui'),
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
