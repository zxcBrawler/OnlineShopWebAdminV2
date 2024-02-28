import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

class OrdersTable extends StatefulWidget {
  const OrdersTable({super.key});

  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
      listener: (context, state) {
        print("123");
      },
      builder: (context, state) {
        return BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case RemoteDeliveryInfoLoading:
                return const Center(child: CircularProgressIndicator());
              case RemoteDeliveryInfoDone:
                return BasicTable(
                  columns: generateColumns(state.info!.first.getProperties()),
                  dataSource: BasicDataSource<DeliveryInfoEntity>(
                    rowsCount: state.info!.length,
                    columnTitles: state.info!.first.getProperties(),
                    data: state.info!,
                  ),
                );
              case RemoteDeliveryInfoError:
                return const Text("error");
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
