import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/const.dart';

class CardCartProduct extends StatefulWidget {
  const CardCartProduct({super.key});

  @override
  State<CardCartProduct> createState() => _CardCartProductState();
}

class _CardCartProductState extends State<CardCartProduct> {
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
                    Text('7, 500 FC - 2 Kg',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500))),
                    verticalSpacer(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuantiteWidget(),
                        ClipOval(
                          child: Material(
                            color: const Color(0XFFFFA834), // button color
                            child: InkWell(
                              splashColor:
                                  AppColors.primaryColorDark, // inkwell color
                              child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuantiteWidget() {
    return SizedBox(
      height: 30,
      child: ClipRRect(
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
                  color: AppColors.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Center(
                        child: Text('-',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)))),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
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
                    isDense: false,
                    isCollapsed: false,
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
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
                  color: AppColors.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Center(
                        child: Text('+',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)))),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
