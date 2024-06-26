import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_users.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  @override

  /// Builds the user interface for the admin users page.
  ///
  /// This function returns a [SafeArea] widget that wraps a
  /// [SingleChildScrollView]. The [SingleChildScrollView] has padding
  /// of 16.0 and contains a [Column] widget. The [Column] contains a
  /// [Header] widget with the title 'users'. It also contains a [Row]
  /// widget with a single child, [AdminTotalUsers], a [AdminTotalActiveUsers]
  /// widget with the title 'total active users', an [AdminUsersWeeklyActivity]
  /// widget, and another [Row] widget with a single child, [UserAddresses],
  /// which has the title 'user addresses'.
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the content with SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView to enable vertical
          // scrolling
          padding: const EdgeInsets.all(16.0),
          // The column for the UI elements
          child: Column(
            children: [
              // Display the header
              Header(
                title: S.of(context).users,
              ),
              // Display the total number of  users
              const Row(
                children: [
                  AdminTotalUsers(),
                ],
              ),
            ],
          )),
    );
  }
}
