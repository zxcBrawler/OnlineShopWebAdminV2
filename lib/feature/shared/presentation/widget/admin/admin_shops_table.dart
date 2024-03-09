import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_state.dart';

class AdminShopsTable extends StatefulWidget {
  const AdminShopsTable({Key? key}) : super(key: key);

  @override
  State<AdminShopsTable> createState() => AdminShopsTableState();
}

class AdminShopsTableState extends State<AdminShopsTable> {
  @override

  /// Builds the widget tree based on the state of the [RemoteShopAddressesBloc].
  ///
  /// Wraps the widget with [BlocProvider] to provide the [RemoteShopAddressesBloc].
  /// Creates an instance of [RemoteShopAddressesBloc] using the [service] method.
  /// Listens for changes in the state of [RemoteShopAddressesBloc] using [BlocBuilder].
  /// Returns the widget tree based on the runtime type of the state.
  Widget build(BuildContext context) {
    // Build the widget tree based on the state of the RemoteShopAddressesBloc
    return BlocProvider<RemoteShopAddressesBloc>(
      // Create an instance of RemoteShopAddressesBloc using the service method
      create: (context) => service()..add(const GetShopAddresses()),
      // Build the widget tree based on the state of RemoteShopAddressesBloc
      child: BlocBuilder<RemoteShopAddressesBloc, RemoteShopAddressState>(
        // Builder method to render the widget based on the state of RemoteShopAddressesBloc
        builder: (_, state) {
          // Switch on the runtime type of the state to handle different cases
          switch (state.runtimeType) {
            // Case when the state is of type RemoteShopAddressLoading
            case RemoteShopAddressLoading:
              // Show loading indicator while fetching data
              return const Center(child: CircularProgressIndicator());
            // Case when the state is of type RemoteShopAddressDone
            case RemoteShopAddressDone:
              // Retrieve the properties of the first shop address in the list
              final List<String> columnTitles =
                  state.shopAddresses!.first.getProperties();
              // Build the BasicTable widget with the generated columns and data
              return BasicTable(
                columns: generateColumns(columnTitles),
                dataSource: BasicDataSource<ShopAddressEntity>(
                  rowsCount: state.shopAddresses!.length,
                  columnTitles: columnTitles,
                  data: state.shopAddresses!,
                ),
              );
            // Case when the state is of type RemoteShopAddressError
            case RemoteShopAddressError:
              // Display error message
              return const Text("error");
          }
          // Return an empty sized box as the default case
          return const SizedBox();
        },
      ),
    );
  }
}
