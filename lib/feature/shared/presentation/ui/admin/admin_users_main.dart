import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_active_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_users_addresses.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_users_weekly_activity.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Header(
                title: 'users',
              ),
              Row(
                children: [
                  AdminTotalUsers(),
                ],
              ),
              AdminTotalActiveUsers(title: "total active users"),
              AdminUsersWeeklyActivity(),
              Row(
                children: [
                  UserAddresses(
                    title: "user addresses",
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
