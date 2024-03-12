import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  @override

  /// Builds the user interface widget tree.
  ///
  /// The method builds a scrollable widget tree that wraps its content
  /// with a [SafeArea] to avoid any overlap with system UI. It uses a
  /// [SingleChildScrollView] to enable vertical scrolling.
  ///
  /// The UI is built differently depending on whether the device is a
  /// desktop or not. For a desktop device, it displays a [Header] widget
  /// with a 'dashboard' title and a [Row] widget with no children. For a
  /// non-desktop device, it also displays a [Header] widget with a
  /// 'dashboard' title.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the content with SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView to enable vertical scrolling
        padding: const EdgeInsets.all(16.0),
        child: Responsive.isDesktop(context)
            ? const Column(
                // Build the UI for a desktop device
                children: [
                  // Display the header
                  Header(title: 'dashboard'),
                  // Display a row with no children
                  Row(children: []),
                ],
              )
            : const Column(
                // Build the UI for a non-desktop device
                children: [
                  // Display the header
                  Header(title: 'dashboard'),
                ],
              ),
      ),
    );
  }
}
