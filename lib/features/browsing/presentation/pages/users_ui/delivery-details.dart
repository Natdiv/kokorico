import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/helpers/utility.dart';
import '../../../../../core/theme/colors.dart';
import '../../../domain/entities/order.dart';

class DeliveryDetailsPage extends StatelessWidget {
  final AppOrder order;

  const DeliveryDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Commandes',
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
        body: _mainBody());
  }

  Widget _mainBody() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buidCardItem('Commande ', order.id!),
          _cardDivder(),
          _buidCardItem('Date', getFormattedDate(order.createdAt)),
          _cardDivder(),
          _buidCardItem('Montant', getFormattedPrice(order.totalPrice)),
          _cardDivder(),
          _buidCardItem('Status', getOrderStatus(order.status))
        ]));
  }

  Widget _buidCardItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))),
        Text(value,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500))),
      ],
    );
  }

  Widget _cardDivder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(
        thickness: 1,
        color: AppColors.primaryColorDark.withOpacity(0.25),
      ),
    );
  }
}
