import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_shops_table.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';

import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';

class AdminShops extends StatefulWidget {
  const AdminShops({super.key});

  @override
  State<AdminShops> createState() => _AdminShopsState();
}

class _AdminShopsState extends State<AdminShops> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Header(
              title: 'shops',
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocProvider<RemoteShopAddressesBloc>(
                              create: (context) =>
                                  service()..add(const GetShopAddresses()),
                              child: const AdminShopsTable(),
                            ), //implement linechart
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
