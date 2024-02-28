import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';

class BasicContainer extends StatelessWidget {
  final Widget child;

  const BasicContainer({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ], color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: child);
  }
}
