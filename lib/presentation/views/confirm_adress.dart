import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/colors.dart';
import 'package:kokorico/core/const.dart';

class ConfirmAdressPage extends StatefulWidget {
  const ConfirmAdressPage({super.key});

  @override
  State<ConfirmAdressPage> createState() => _ConfirmAdressPageState();
}

class _ConfirmAdressPageState extends State<ConfirmAdressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Confirmation de l\'adresse',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            _buildCurrentAddressWidget(),
            verticalSpacer(height: 8),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Liver à votre position actuelle',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: AppColors.primaryColorDark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))),
                              const Icon(
                                Icons.my_location,
                                color: AppColors.primaryColorDark,
                                size: 16,
                              )
                            ],
                          ),
                          verticalSpacer(height: 16),
                          // Place to place the Map
                          // Container(
                          //   height: 300,
                          //   width: double.infinity,
                          //   clipBehavior: Clip.hardEdge,
                          //   decoration: BoxDecoration(
                          //     color: AppColors.cardColor,
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Image.asset('assets/images/maps.png',
                          //       fit: BoxFit.cover),
                          // ),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                        'Recuperer ma position actuelle',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpacer(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Continuer',
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: AppColors.primaryColorDark,
                                          ),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: AppColors.primaryColorDark,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])))
          ]),
        ),
      ),
    );
  }

  Widget _buildCurrentAddressWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Livrer à cette adresse',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColorDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))),
          verticalSpacer(height: 8),
          Text('09, Avenue de la paix, Jolie Site, Kolwezi',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500))),
          verticalSpacer(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Continuer',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColorDark,
                          ),
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.primaryColorDark,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
