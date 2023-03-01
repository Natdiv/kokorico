import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'empty_widget.dart';

class AccessDeniedPage extends StatefulWidget {
  const AccessDeniedPage({super.key});

  @override
  State<AccessDeniedPage> createState() => _AccessDeniedPageState();
}

class _AccessDeniedPageState extends State<AccessDeniedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EmptyWidget(
        message: 'Vous n\'avez pas acces a cette page',
        imageSrc: 'assets/images/access_denied.svg',
      ),
    );
  }
}
