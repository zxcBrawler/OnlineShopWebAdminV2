import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/constants/shared_prefs.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/charts/total_items_piechart.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/charts/total_orders_pie_chart.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_users.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/config/responsive.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: !Responsive.isDesktop(context)
              ? const Column(
                  children: [
                    Header(
                      title: 'dashboard',
                    ),
                    Row(
                      children: [
                        AdminTotalUsers(),
                        AdminTotalOrders(),
                      ],
                    )
                  ],
                )
              : const Column(
                  children: [
                    Header(
                      title: 'dashboard',
                    ),
                    Row(
                      children: [
                        AdminTotalUsers(),
                        AdminTotalOrders(),
                        AdminTotalItemsPiechart()
                      ],
                    )
                  ],
                )),
    );
  }

  Future<void> loadAccessToken() async {
    String? token = await SharedPreferencesManager.loadAccessToken();
    setState(() {
      accessToken = token;
    });
  }
}
