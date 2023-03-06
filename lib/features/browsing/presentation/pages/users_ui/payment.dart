import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/const.dart';
import 'package:kokorico/features/browsing/data/models/orders_model.dart';
import 'package:kokorico/features/browsing/presentation/pages/common/loading_page.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/enum.dart';
import '../../../../../core/theme/colors.dart';
import '../../controllers/data_controller.dart';
import '../../state/auth_state.dart';
import '../../state/order_state.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController _phoneController;
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  String errorText = '';
  DataController dataController = DataController();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    focusNode.requestFocus();
  }

  @override
  dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderState = Provider.of<OrderState>(context);
    final authState = Provider.of<AuthState>(context);
    return (authState.isbusy)
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: AppColors.primaryColorDark,
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: formKey,
                    child: SizedBox(
                      height: size(context).height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Paiement',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryColorDark,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Text(
                            'Entrez le numéro de téléphone avec lequel vous voulez effectuer le paiement',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppColors.primaryColorDark
                                        .withOpacity(0.80),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          _buildPhoneField(context),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(errorText,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 255, 73, 52),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 50,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    _makePayment();
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'Lancer le processus',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Divider(
                            color: AppColors.primaryColorDark.withOpacity(0.25),
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Paiement disponible avec',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: AppColors.primaryColorDark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Image.asset(
                                      'assets/images/airtel-money.png',
                                      height: 27,
                                      width: 48,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Image.asset(
                                      'assets/images/m-pesa.png',
                                      height: 27,
                                      width: 48,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Image.asset(
                                      'assets/images/orange-money.png',
                                      height: 27,
                                      width: 48,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Divider(
                            color: AppColors.primaryColorDark.withOpacity(0.25),
                            thickness: 1,
                          ),
                          verticalSpacer(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: Center(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Je paie à la livraison ',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: AppColors.primaryColorDark,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))),
                                TextSpan(
                                    text: 'Continuer',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        orderState.paymentMethod =
                                            PaymentMethod.CASH.toString();

                                        /// To add if payment is no online payment
                                        /// orderState.paymentPhone = '';
                                        // orderState.paymentStatus = PaymentStatus.PENDING.toString();
                                      },
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            // decoration: TextDecoration.underline,
                                            color: AppColors.primaryColorDark,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)))
                              ])),
                            ),
                          ),
                          verticalSpacer(height: 32)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Text(
            '+243',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 20,
              width: 1,
              color: AppColors.primaryColor,
            ),
          ),
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              controller: _phoneController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              minLines: 1,
              decoration: const InputDecoration(
                  hintText: 'Téléphone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  // border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }

  _makePayment() {
    final authState = Provider.of<AuthState>(context, listen: false);
    final orderState = Provider.of<OrderState>(context, listen: false);
    var phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      setState(() {
        errorText = 'Veuillez saisir votre numero';
      });
    } else if (phone.length != 9) {
      setState(() {
        errorText =
            'Votre numero doit contenir au moins 9 chiffres\n(ex: 97 222 22 22)';
      });
    } else if (!'+243$phone'.isPhoneNumber) {
      setState(() {
        errorText = 'Ce numero est invalide';
      });
    } else {
      authState.isBusy = true;
      orderState.paymentPhone = '+243$phone';
      orderState.paymentMethod = PaymentMethod.MOBILE_MONEY.toString();

      setState(() {
        errorText = '';
      });

      /// Here you can make your payment
      print('${orderState.paymentPhone}, ${orderState.totalPrice}');
      dataController
          .makeMobilePayment('orderState.paymentPhone!', orderState.totalPrice!)
          .then((value) {
        print(value);
        authState.isBusy = false;

        /// To add if payment is successfully
        // orderState.paymentStatus = PaymentStatus.PAID.toString();
        // Add order to firestore
        // Route to /orders Page or Success Page
      }).catchError((onError) {
        print(onError);
        authState.isBusy = false;
      });
    }
  }

  OrderModel fillOrder() {
    final authState = Provider.of<AuthState>(context, listen: false);
    final orderState = Provider.of<OrderState>(context, listen: false);

    return OrderModel(
        userId: authState.userId,
        status: OrderStatus.PENDING.toString(),
        paymentMethod: orderState.paymentMethod!,
        paymentStatus: orderState.paymentStatus!,
        deliveryStatus: DeliveryStatus.PENDING.toString(),
        deliveryAddress: orderState.deliveryAddress!,
        referenceAddress: orderState.referenceAddress!,
        deliveryCity: orderState.deliveryCity,
        deliveryCountry: orderState.deliveryCountry,
        deliveryPhone: authState.appUser!.phoneNumber,
        paymentPhone: orderState.paymentPhone!,
        deliveryEmail: authState.appUser!.email,
        deliveryNotes: orderState.deliveryNotes,
        deliveryDate: DateTime.now().millisecondsSinceEpoch,
        deliveryPrice: orderState.totalPrice!,
        totalPrice: orderState.totalPrice!,
        products: orderState.products!,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch);
  }
}
