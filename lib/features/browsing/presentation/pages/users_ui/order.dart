import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kokorico/core/const.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../controllers/data_controller.dart';
import '../../state/cart_state.dart';
import '../../state/order_state.dart';
import '../common/empty_widget.dart';
import '../common/widgets/shimmer_list.dart';

class OrderPage extends StatelessWidget {
  final bool isFromCart;
  final ProductModel? product;
  final int? quantity;

  final DataController _dataController = DataController();
  List<Map<String, int>>? orderProducts = [];
  double totalPrice = 0;

  /// The [isFromCart] argument is used to know
  /// if the user is coming from the cart page
  /// or from the product details page
  OrderPage({super.key, required this.isFromCart, this.product, this.quantity});

  TextStyle titleStyle = GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
  TextStyle contentStyle = GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500));

  @override
  Widget build(BuildContext context) {
    var cartState = Provider.of<CartState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ma Commande',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.primaryColorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.primaryColorDark,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: (isFromCart)
                ? _dataController.getCart(cartState.getCart)
                : _dataController.getCart([
                    {product!.id!: quantity!}
                  ]),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                    message: 'Votre panier est vide',
                    imageSrc: 'assets/images/empty_cart.svg',
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
                      message: 'Votre panier est vide',
                      imageSrc: 'assets/images/empty_cart.svg',
                    );
                  }
                  return _mainBody(context, data as List<ProductModel>);
                });
              }
            }),
      ),
    );
  }

  Widget _mainBody(BuildContext context, List<ProductModel> data) {
    var cartState = Provider.of<CartState>(context, listen: false);
    return Column(
      children: [
        Expanded(
          // fit: FlexFit.tight,
          // height: size(context).height * 0.75,
          child: DataTable2(
            // columnSpacing: defaultPadding,
            // minWidth: 600,
            smRatio: 0.5,
            lmRatio: 2,
            columnSpacing: 0,
            horizontalMargin: 0,
            columns: [
              DataColumn2(
                label: Text("No", style: titleStyle),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text("Produit", style: titleStyle),
              ),
              DataColumn2(
                  label: Center(child: Text("Prix (FC)", style: titleStyle)),
                  numeric: true),
              DataColumn2(
                  label: Center(child: Text("Qté", style: titleStyle)),
                  numeric: true),
              DataColumn2(
                  label: Center(child: Text("Total", style: titleStyle)),
                  numeric: true),
            ],
            rows: List.generate(
              data.length,
              (index) {
                int qty = (isFromCart)
                    ? cartState.getQuantity(data[index].id!)
                    : quantity!;
                orderProducts!.add({data[index].id!: qty});
                totalPrice += data[index].price * qty;

                return orderDataRow(context, data[index], qty, index + 1);
              },
            ),
          ),
        ),
        Spacer(),
        Divider(
          thickness: 1,
          color: AppColors.primaryColorDark.withOpacity(0.25),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Total', style: titleStyle.copyWith(fontSize: 20)),
            Text(
              (isFromCart)
                  ? '${NumberFormat.simpleCurrency(locale: 'fr_FR', name: '', decimalDigits: 0).format(cartState.getTotalPrice(data).round())} FC'
                  : '${NumberFormat.simpleCurrency(locale: 'fr_FR', name: '', decimalDigits: 0).format(product!.price * quantity!)} FC',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: AppColors.primaryColorDark.withOpacity(0.25),
        ),
        verticalSpacer(height: 16),
        roundedButton(context),
        Spacer()
      ],
    );
  }

  DataRow orderDataRow(
      BuildContext context, ProductModel product, int qty, int index) {
    var f = NumberFormat.simpleCurrency(name: '', decimalDigits: 0);
    return DataRow2(
      cells: [
        DataCell(Text(index.toString(),
            style: contentStyle.copyWith(fontWeight: FontWeight.bold))),
        DataCell(Text(product.name, style: contentStyle)),
        DataCell(Center(
            child: Text(f.format(product.price.round()), style: contentStyle))),
        DataCell(Center(child: Text(qty.toString(), style: contentStyle))),
        DataCell(Center(
            child: Text(f.format(product.price.round() * qty),
                style: contentStyle))),
      ],
    );
  }

  Widget roundedButton(BuildContext context) {
    var orderState = Provider.of<OrderState>(context, listen: false);

    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            print('totalPrice: $totalPrice');
            orderState.products = orderProducts ?? [];
            orderState.totalPrice = totalPrice;

            Routes.goTo(context, '/confirmation-address');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Center(
              child: Text('Valider',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
            ),
          ),
        ),
      ),
    );
  }
}
