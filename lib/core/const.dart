import 'package:flutter/material.dart';

Widget verticalSpacer({double height = 20}) {
  return SizedBox(height: height);
}

Size size(BuildContext context) {
  return MediaQuery.of(context).size;
}
