import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kokorico/core/helpers/routes.dart';
import 'package:kokorico/core/helpers/utility.dart';
import 'package:kokorico/features/browsing/data/models/orders_model.dart';
import 'package:kokorico/features/browsing/presentation/pages/common/widgets/shimmer_list.dart';
import 'package:kokorico/features/browsing/presentation/state/auth_state.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/colors.dart';
import '../../controllers/data_controller.dart';
import '../common/empty_widget.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final DataController _dataController = DataController();

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context, listen: false);
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
      body: FutureBuilder(
          future: _dataController.getMyOrders(authState.userId),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Shimmer Orders');
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
              print('All Orders');
              final result = snapshot.data;
              return result!.fold((failure) {
                print(failure.props.first.toString());
                return const EmptyWidget(
                  message: 'Une erreur inconnue est survenue',
                  imageSrc: 'assets/images/cancel.svg',
                );
              }, (data) {
                if (data.isEmpty) {
                  return const EmptyWidget(
                    message: 'Vous n\'avez pas encore passé de commande',
                    imageSrc: 'assets/images/no_data.svg',
                  );
                }
                return _mainBody(data as List<OrderModel>);
              });
            }
          }),
    );
  }

  Widget _mainBody(List<OrderModel> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, index) {
            return _orderItem(data[index]);
          }),
    );
  }

  Widget _orderItem(OrderModel data) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Routes.goTo(context, '/delivery-details', args: data);
        },
        child: Card(
            color: AppColors.cardColor,
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buidCardItem('Commande N°', data.id!),
                      _cardDivder(),
                      _buidCardItem('Date', getFormattedDate(data.createdAt)),
                      _cardDivder(),
                      _buidCardItem(
                          'Montant', getFormattedPrice(data.totalPrice)),
                      _cardDivder(),
                      _buidCardItem('Status', getOrderStatus(data.status)),
                      _cardDivder(),
                      _buidCardItem('Adresse', data.deliveryAddress),
                      _cardDivder(),
                      _buidCardItem('Téléphone', data.deliveryPhone),
                      _cardDivder(),
                      _buidCardItem('Mode de paiement',
                          getPaymentMethod(data.paymentMethod)),
                      _cardDivder(),
                      _buidCardItem('Téléphone', data.deliveryPhone),
                    ]))),
      ),
    );
  }

  Widget _buidCardItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        Text(value,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _cardDivder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        thickness: 1,
        color: AppColors.primaryColorDark.withOpacity(0.25),
      ),
    );
  }
}
