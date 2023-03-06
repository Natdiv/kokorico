import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/helpers/routes.dart';
import 'package:kokorico/features/browsing/presentation/state/auth_state.dart';
import 'package:kokorico/features/browsing/presentation/state/order_state.dart';
import 'package:provider/provider.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/const.dart';

class ConfirmationAddressPage extends StatefulWidget {
  const ConfirmationAddressPage({super.key});

  @override
  State<ConfirmationAddressPage> createState() =>
      _ConfirmationAddressPageState();
}

class _ConfirmationAddressPageState extends State<ConfirmationAddressPage> {
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
            verticalSpacer(height: 16),
            // Pour la geolocation
            // _buidPositionAcuelleWidget()
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Ou',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppColors.primaryColorDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w400))),
            ),
            _buidDifferentAddress()
          ]),
        ),
      ),
    );
  }

  /// Cette methode est prevue pour la fonction de geolocalisation
  Widget _buidPositionAcuelleWidget() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        child: Text('Recuperer ma position actuelle',
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
                              fontWeight: FontWeight.bold)),
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
            ])));
  }

  Widget _buildCurrentAddressWidget() {
    final authState = Provider.of<AuthState>(context);
    final orderState = Provider.of<OrderState>(context);
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
          Text(authState.appUser!.address,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500))),
          Text(authState.appUser!.referenceAddress!,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500))),
          verticalSpacer(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  orderState.deliveryAddress = authState.appUser!.address;
                  orderState.referenceAddress =
                      authState.appUser!.referenceAddress ?? '';
                  Routes.goTo(context, '/payment');
                },
                child: Text('Continuer',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: AppColors.primaryColorDark,
                        ),
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
              ),
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
        ]),
      ),
    );
  }

  /// Choose a different address
  Widget _buidDifferentAddress() {
    // final authState = Provider.of<AuthState>(context);
    TextEditingController addressController = TextEditingController();
    TextEditingController referenceAddressController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final orderState = Provider.of<OrderState>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Spécifier une adresse différente',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.primaryColorDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))),
          verticalSpacer(height: 8),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir une adresse de livraison';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Adresse de livraison',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                verticalSpacer(height: 8),
                TextFormField(
                  controller: referenceAddressController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir une réference pour plus de précision';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Reference de l\'adresse',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ],
            ),
          ),
          verticalSpacer(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  orderState.deliveryAddress = addressController.text.trim();
                  orderState.referenceAddress =
                      referenceAddressController.text.trim();
                  Routes.goTo(context, '/payment');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Continuer',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColorDark,
                          ),
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
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
