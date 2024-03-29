import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';

// Style for the dropdown container
Container dropdownContainer(Widget child) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.lightGray)),
      child: child);
}
