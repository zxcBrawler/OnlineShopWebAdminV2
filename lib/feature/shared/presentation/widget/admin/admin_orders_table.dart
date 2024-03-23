import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

class OrdersTable extends StatefulWidget {
  const OrdersTable({super.key});

  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  String _searchQuery = ''; // Store the search query
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),
        BlocProvider<RemoteDeliveryInfoBloc>(
          create: (context) => service()..add(const GetDeliveryInfo()),
          child: BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
            builder: (_, state) {
              switch (state.runtimeType) {
                case RemoteDeliveryInfoLoading:
                  return const Center(child: CircularProgressIndicator());
                case RemoteDeliveryInfoDone:
                  final List<DeliveryInfoEntity> allOrders = state.info!
                      .where((element) =>
                          element.order!.numberOrder!.contains(_searchQuery))
                      .toList();
                  return BasicTable(
                    columns: generateColumns(state.info!.first.getProperties()),
                    dataSource: BasicDataSource<DeliveryInfoEntity>(
                      rowsCount: allOrders.length,
                      columnTitles: state.info!.first.getProperties(),
                      data: allOrders,
                    ),
                  );
                case RemoteDeliveryInfoError:
                  return const Text("error");
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
