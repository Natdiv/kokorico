import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import 'empty_widget.dart';

class AccessDeniedPage extends StatefulWidget {
  const AccessDeniedPage({super.key});

  @override
  State<AccessDeniedPage> createState() => _AccessDeniedPageState();
}

class _AccessDeniedPageState extends State<AccessDeniedPage> {
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
      ),
      body: const EmptyWidget(
        message: 'Vous n\'avez pas acces a cette page',
        imageSrc: 'assets/images/access_denied.svg',
      ),
    );
  }
}
