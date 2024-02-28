import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_users_addresses.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_users_weekly_activity.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_active_users.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/config/responsive.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: !Responsive.isDesktop(context)
              ? const Column(
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
                    Row(
                      children: [
                        UserAddresses(
                          title: "user addresses",
                        ),
                      ],
                    ),
                  ],
                )
              : const Column(
                  children: [
                    Header(
                      title: 'users',
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  AdminTotalUsers(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AdminTotalActiveUsers(
                                  title: "total active users"),
                              AdminUsersWeeklyActivity(),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            UserAddresses(
                              title: "user addresses",
                            )
                          ],
                        ))
                      ],
                    )
                  ],
                )),
    );
  }
}
