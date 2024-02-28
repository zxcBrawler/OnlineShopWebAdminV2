import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_state.dart';

class AdminShopsTable extends StatefulWidget {
  const AdminShopsTable({Key? key}) : super(key: key);

  @override
  State<AdminShopsTable> createState() => AdminShopsTableState();
}

class AdminShopsTableState extends State<AdminShopsTable> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteShopAddressesBloc, RemoteShopAddressState>(
      listener: (context, state) {
        print("123");
      },
      builder: (context, state) {
        return BlocBuilder<RemoteShopAddressesBloc, RemoteShopAddressState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case RemoteShopAddressLoading:
                return const Center(child: CircularProgressIndicator());
              case RemoteShopAddressDone:
                return BasicTable(
                  columns: generateColumns(
                      state.shopAddresses!.first.getProperties()),
                  dataSource: BasicDataSource<ShopAddressEntity>(
                    rowsCount: state.shopAddresses!.length,
                    columnTitles: state.shopAddresses!.first.getProperties(),
                    data: state.shopAddresses!,
                  ),
                );
              case RemoteShopAddressError:
                return const Text("error");
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
