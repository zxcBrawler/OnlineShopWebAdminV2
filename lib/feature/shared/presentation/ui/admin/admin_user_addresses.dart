import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_shops_table.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';

class AdminUserAddresses extends StatefulWidget {
  const AdminUserAddresses({super.key});

  @override
  State<AdminUserAddresses> createState() => _AdminUserAddressesState();
}

class _AdminUserAddressesState extends State<AdminUserAddresses> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BasicContainer(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                        child: AdminShopsTable()), //implement linechart
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
