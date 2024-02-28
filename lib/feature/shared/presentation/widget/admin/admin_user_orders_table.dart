import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

class UserOrdersTable extends StatefulWidget {
  final UserEntity user;
  const UserOrdersTable({super.key, required this.user});

  @override
  State<UserOrdersTable> createState() => _UserOrdersTableState();
}

class _UserOrdersTableState extends State<UserOrdersTable> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteDeliveryInfoBloc>(
      create: (context) => service()..add(const GetDeliveryInfo()),
      child: BlocConsumer<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
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
                  List<DeliveryInfoEntity> userOrders = state.info!
                      .where((element) =>
                          element.order?.userCard?.user?.id == widget.user.id)
                      .toList();
                  if (userOrders.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BasicText(title: "no orders"),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicTable(
                      columns:
                          generateColumns(userOrders.first.getProperties()),
                      dataSource: BasicDataSource<DeliveryInfoEntity>(
                        rowsCount: userOrders.length,
                        columnTitles: userOrders.first.getProperties(),
                        data: userOrders,
                      ),
                    ),
                  );
                case RemoteDeliveryInfoError:
                  return const Text("error");
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
